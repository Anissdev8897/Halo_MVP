<#
.SYNOPSIS
    HaloRP Launcher — version check (GitHub Releases) + integrity check (SHA256) + Steam launch.

.DESCRIPTION
    Workflow à chaque lancement :
      1. Lit manifest.json local du pack
      2. Compare avec dernière Release GitHub via API
      3. Si nouvelle version : DL le ZIP, l'extrait, run install.ps1
      4. Vérifie SHA256 des .mvar/.bin en LocalLow (détection tampering)
      5. Modal WPF : rappel AC OFF
      6. Lance MCC via steam://rungameid/976730

    Compatible PowerShell 5.1 et PowerShell 7+.

.PARAMETER ManifestPath
    Chemin vers le manifest local. Défaut: ../gamepacks/halo_reach_mvp_v0.1/manifest.json

.PARAMETER SkipUpdateCheck
    Skip l'appel GitHub Releases API. Mode offline / dev.

.PARAMETER SkipIntegrityCheck
    Skip la vérification SHA256 des fichiers LocalLow. Plus rapide mais moins safe.

.PARAMETER NoModal
    Skip la modal WPF "AC OFF reminder". Pour CI / power-user.

.PARAMETER NoPause
    Skip le Read-Host final. Pour CI / chaining.

.EXAMPLE
    .\halorp_launcher.ps1
    Lancement standard avec tous les checks.

.EXAMPLE
    .\halorp_launcher.ps1 -SkipUpdateCheck
    Mode offline (pas d'appel GitHub API).

.NOTES
    Projet : HaloRP MVP
    Repo   : github.com/Anissdev8897/Halo_MVP
    Voir   : gamepacks/halo_reach_mvp_v0.1/install.ps1, manifest.json
#>

[CmdletBinding()]
param(
    [string]$ManifestPath,
    [switch]$SkipUpdateCheck,
    [switch]$SkipIntegrityCheck,
    [switch]$NoModal,
    [switch]$NoPause,
    # Skip l'appel steam://rungameid (test / dry-run, ne lance pas MCC).
    [switch]$NoLaunch
)

$ErrorActionPreference = "Stop"
try { [System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

# === GUARD : PS version ===
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Host "PowerShell 5.0+ requis. Tu as PS $($PSVersionTable.PSVersion)." -ForegroundColor Red
    if (-not $NoPause) { try { [void](Read-Host "Press Enter to close") } catch {} }
    exit 2
}

# === CONFIGURATION ===
$LauncherVersion   = "0.1.0"
$GitHubRepo        = "Anissdev8897/Halo_MVP"
$GitHubReleasesAPI = "https://api.github.com/repos/$GitHubRepo/releases/latest"
$DiscordInvite     = "https://discord.gg/halorp"  # TODO: remplacer par le vrai invite
$MccAppId          = "976730"

if (-not $ManifestPath) {
    $ManifestPath = Join-Path $PSScriptRoot "..\gamepacks\halo_reach_mvp_v0.1\manifest.json"
}

# === HELPERS ===

function Write-Step { param([string]$Msg) Write-Host "[*] $Msg" -ForegroundColor Cyan }
function Write-Ok   { param([string]$Msg) Write-Host "    OK  $Msg" -ForegroundColor Green }
function Write-Warn { param([string]$Msg) Write-Host "    !!  $Msg" -ForegroundColor Yellow }
function Write-Info { param([string]$Msg) Write-Host "        $Msg" -ForegroundColor DarkGray }
function Write-Err  { param([string]$Msg) Write-Host "    XX  $Msg" -ForegroundColor Red }

function Get-FileSha256 {
    param([string]$Path)
    return (Get-FileHash -Path $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Confirm-UserAction {
    param([string]$Question)
    do {
        $resp = (Read-Host "$Question (o/n)").ToLower().Trim()
    } while ($resp -ne 'o' -and $resp -ne 'n' -and $resp -ne 'y' -and $resp -ne 'yes' -and $resp -ne 'oui' -and $resp -ne 'non' -and $resp -ne 'no')
    return ($resp -in @('o', 'y', 'yes', 'oui'))
}

function Show-AcOffModal {
    Add-Type -AssemblyName PresentationFramework
    $result = [System.Windows.MessageBox]::Show(
        "RAPPEL CRITIQUE`r`n`r`nDans le launcher MCC qui va s'ouvrir :`r`n  -> Coche 'Anti-Cheat OFF' AVANT de cliquer Play.`r`n`r`nSans AC OFF, les Custom Games HaloRP ne marcheront pas (variantes custom invisibles).`r`n`r`nContinuer le lancement ?",
        "HaloRP Launcher - AC OFF requis",
        "OKCancel",
        "Warning"
    )
    return ($result -eq "OK")
}

function Get-LocalManifest {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        throw "Manifest local introuvable: $Path. Repo HaloRP_MVP est-il bien checkout ?"
    }
    return Get-Content $Path -Raw -Encoding UTF8 | ConvertFrom-Json
}

function Get-LocalLowDir {
    param([object]$Manifest)
    if ($Manifest.target_dir_env -ne "USERPROFILE") {
        throw "target_dir_env inattendu dans le manifest: $($Manifest.target_dir_env)"
    }
    $dir = Join-Path $env:USERPROFILE ($Manifest.target_dir_path -replace '/', '\')
    if ($dir -notmatch 'LocalLow\\MCC\\') {
        throw "Sécurité: target_dir_path hors LocalLow\MCC refusé."
    }
    return $dir
}

function Invoke-AutoUpdate {
    param(
        [object]$LatestRelease,
        [object]$LocalManifest
    )
    Write-Step "Téléchargement de la nouvelle version"
    $zipAsset = $LatestRelease.assets | Where-Object { $_.name -like "*.zip" } | Select-Object -First 1
    if (-not $zipAsset) {
        throw "Aucun asset .zip dans la Release $($LatestRelease.tag_name). Vérifie la page Releases sur GitHub."
    }
    Write-Info "Asset    : $($zipAsset.name)"
    Write-Info "Taille   : $([math]::Round($zipAsset.size / 1KB, 1)) KB"
    Write-Info "URL      : $($zipAsset.browser_download_url)"

    $tempZip = Join-Path $env:TEMP "halorp_$($zipAsset.name)"
    $tempDir = Join-Path $env:TEMP "halorp_extract_$([guid]::NewGuid().ToString().Substring(0,8))"

    Invoke-WebRequest -Uri $zipAsset.browser_download_url -OutFile $tempZip -UseBasicParsing
    Write-Ok "Téléchargé: $tempZip"

    Expand-Archive -Path $tempZip -DestinationPath $tempDir -Force
    Write-Ok "Extrait dans: $tempDir"

    $installScript = Get-ChildItem -Path $tempDir -Recurse -Filter "install.ps1" | Select-Object -First 1
    if (-not $installScript) {
        throw "install.ps1 introuvable dans le ZIP téléchargé."
    }

    Write-Step "Exécution de install.ps1 (fenêtre séparée)"
    $proc = Start-Process -FilePath "powershell.exe" -ArgumentList @(
        "-NoProfile",
        "-ExecutionPolicy", "Bypass",
        "-File", "`"$($installScript.FullName)`"",
        "-NoPause",
        "-Force"
    ) -Wait -PassThru
    if ($proc.ExitCode -ne 0) {
        throw "install.ps1 a échoué (exit code $($proc.ExitCode)). Vérifie la fenêtre d'install."
    }
    Write-Ok "Install terminé."

    # Cleanup temp
    Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
    Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Info "Temp nettoyé."
}

function Test-PayloadIntegrity {
    param(
        [object]$Manifest,
        [string]$BaseDir
    )
    $issues = @()
    $payload = if ($Manifest.payload) { @($Manifest.payload) } else { @() }
    foreach ($entry in $payload) {
        $destAbs = Join-Path $BaseDir ($entry.dest -replace '/', '\')
        if (-not (Test-Path $destAbs)) {
            $issues += [PSCustomObject]@{ file = $entry.dest; reason = "manquant" }
            continue
        }
        $hash = Get-FileSha256 -Path $destAbs
        if ($hash -ne $entry.sha256) {
            $issues += [PSCustomObject]@{ file = $entry.dest; reason = "SHA256 mismatch" }
        }
    }
    return $issues
}

# === MAIN ===

$failed = $false

try {
    Write-Host ""
    Write-Host "HaloRP Launcher v$LauncherVersion" -ForegroundColor Magenta
    Write-Host ("=" * 60) -ForegroundColor Magenta

    # 1. Lecture du manifest local
    Write-Step "Lecture du manifest local"
    $localManifest = Get-LocalManifest -Path $ManifestPath
    Write-Ok "Pack local : $($localManifest.pack_name) v$($localManifest.version)"

    # 2. Version check (sauf -SkipUpdateCheck)
    if ($SkipUpdateCheck) {
        Write-Step "Version check skippé (-SkipUpdateCheck)"
    } else {
        Write-Step "Vérification version vs GitHub Releases"
        try {
            $latestRelease = Invoke-RestMethod -Uri $GitHubReleasesAPI -Headers @{ "User-Agent" = "HaloRP-Launcher/$LauncherVersion" } -TimeoutSec 5
            $remoteVersion = $latestRelease.tag_name -replace '^v', ''
            Write-Info "Local  : v$($localManifest.version)"
            Write-Info "GitHub : v$remoteVersion"
            if ($remoteVersion -ne $localManifest.version) {
                Write-Warn "Nouvelle version disponible: v$remoteVersion"
                if (Confirm-UserAction "Update maintenant ?") {
                    Invoke-AutoUpdate -LatestRelease $latestRelease -LocalManifest $localManifest
                    # Re-lit le manifest après update
                    $localManifest = Get-LocalManifest -Path $ManifestPath
                    Write-Ok "Manifest rechargé: v$($localManifest.version)"
                } else {
                    Write-Warn "Update reporté. Tu joues en v$($localManifest.version) — possibles incompat avec les autres joueurs."
                }
            } else {
                Write-Ok "Pack à jour"
            }
        } catch [System.Net.WebException] {
            if ($_.Exception.Response.StatusCode -eq 'NotFound') {
                Write-Warn "Aucune Release GitHub trouvée (404). Repo vide ou aucune Release publiée."
                Write-Info "Lancement en v$($localManifest.version) local."
            } else {
                Write-Warn "Vérification remote impossible: $($_.Exception.Message)"
                Write-Info "Lancement en v$($localManifest.version) local (offline ?)."
            }
        } catch {
            Write-Warn "Erreur version check: $($_.Exception.Message)"
            Write-Info "Lancement en v$($localManifest.version) local."
        }
    }

    # 3. Integrity check (sauf -SkipIntegrityCheck)
    if ($SkipIntegrityCheck) {
        Write-Step "Integrity check skippé (-SkipIntegrityCheck)"
    } else {
        Write-Step "Vérification SHA256 des fichiers en LocalLow"
        $baseDir = Get-LocalLowDir -Manifest $localManifest
        $issues = Test-PayloadIntegrity -Manifest $localManifest -BaseDir $baseDir
        if ($issues.Count -gt 0) {
            Write-Warn "$($issues.Count) fichier(s) avec problème:"
            foreach ($iss in $issues) {
                Write-Info "  - $($iss.file) [$($iss.reason)]"
            }
            if (Confirm-UserAction "Re-installer maintenant ?") {
                $localInstall = Join-Path (Split-Path $ManifestPath -Parent) "install.ps1"
                if (-not (Test-Path $localInstall)) {
                    throw "install.ps1 local introuvable: $localInstall"
                }
                $proc = Start-Process -FilePath "powershell.exe" -ArgumentList @(
                    "-NoProfile", "-ExecutionPolicy", "Bypass",
                    "-File", "`"$localInstall`"", "-NoPause", "-Force"
                ) -Wait -PassThru
                if ($proc.ExitCode -ne 0) {
                    throw "Re-install échoué (exit $($proc.ExitCode))"
                }
                Write-Ok "Re-install terminé."
            } else {
                throw "Pack corrompu et re-install refusé — impossible de lancer en l'état."
            }
        } else {
            $payloadCount = if ($localManifest.payload) { @($localManifest.payload).Count } else { 0 }
            if ($payloadCount -eq 0) {
                Write-Warn "Manifest sans payload — rien à vérifier (pack en cours de préparation)."
            } else {
                Write-Ok "$payloadCount fichier(s) intègres"
            }
        }
    }

    # 4. Modal AC OFF (sauf -NoModal)
    if ($NoModal) {
        Write-Step "Modal AC OFF skippé (-NoModal)"
    } else {
        Write-Step "Confirmation AC OFF"
        $confirmed = Show-AcOffModal
        if (-not $confirmed) {
            Write-Warn "Lancement annulé par l'utilisateur."
            return
        }
        Write-Ok "AC OFF confirmé"
    }

    # 5. Lancement MCC via Steam URI
    if ($NoLaunch) {
        Write-Step "Steam launch skippé (-NoLaunch)"
    } else {
        Write-Step "Lancement de MCC via Steam"
        Start-Process "steam://rungameid/$MccAppId"
        Write-Ok "MCC lancé. Bon RP."
    }

    Write-Host ""
    Write-Host "=== LAUNCHER OK ===" -ForegroundColor Green
    Write-Host ""
}
catch {
    $failed = $true
    Write-Host ""
    Write-Host "=== LAUNCHER ECHOUE ===" -ForegroundColor Red
    Write-Err $_.Exception.Message
    Write-Host ""
    Write-Host "Détails techniques :" -ForegroundColor DarkGray
    Write-Host "  PS       : $($PSVersionTable.PSVersion)" -ForegroundColor DarkGray
    Write-Host "  OS       : $([System.Environment]::OSVersion.VersionString)" -ForegroundColor DarkGray
    Write-Host "  StackTrc :" -ForegroundColor DarkGray
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
}
finally {
    if (-not $NoPause) {
        Write-Host ""
        Write-Host "Appuie sur Entrée pour fermer." -ForegroundColor DarkGray
        try { [void](Read-Host) } catch {}
    }
}

if ($failed) { exit 1 } else { exit 0 }
