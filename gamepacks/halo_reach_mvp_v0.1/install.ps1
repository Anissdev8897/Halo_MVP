<#
.SYNOPSIS
    Installeur HaloRP Game Pack — copie les payloads (.mvar / .bin) vers MCC LocalLow.

.DESCRIPTION
    Lit manifest.json voisin, vérifie le build MCC du joueur (strict par défaut),
    copie chaque payload vers %USERPROFILE%\AppData\LocalLow\MCC\Temporary\
    UserContent\HaloReach\, vérifie SHA256 source ET destination, log le tout.

    Compatible PowerShell 5.1 (Win10/11 default) et PowerShell 7+.

    Workflow joueur :
        1. Dézipper halo_reach_mvp_v0.1.zip
        2. Clic droit sur install.ps1 -> Run with PowerShell
        3. Si bloqué : ouvrir PowerShell admin, exécuter
           Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
        4. Relancer install.ps1

.PARAMETER IgnoreMccBuildMismatch
    Passe outre la vérification stricte du build MCC. Réservé power-users.
    En mode strict (défaut), un mismatch bloque l'installation.

.PARAMETER Force
    Écrase les fichiers existants sans avertissement (réservé re-install propre).

.EXAMPLE
    .\install.ps1
    Installation standard avec vérification stricte.

.EXAMPLE
    .\install.ps1 -IgnoreMccBuildMismatch
    Installe même si MCC est sur un autre build (tu sais ce que tu fais).

.NOTES
    Projet : HaloRP MVP
    Pack   : halo_reach_mvp v0.1
    Voir   : manifest.json (spec auto-générée par tools/package_gamepack.ps1)
#>

[CmdletBinding()]
param(
    [switch]$IgnoreMccBuildMismatch,
    [switch]$Force,
    # Skip the final "Press Enter" pause. Pour CI / automated test.
    [switch]$NoPause
)

$ErrorActionPreference = "Stop"

# Affichage UTF-8 console (PS 5.1 par défaut sort en OEM codepage)
try { [System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8 } catch {}

# === GUARD : PS version ===
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Host "PowerShell 5.0+ requis (Get-FileHash). Tu as PS $($PSVersionTable.PSVersion)." -ForegroundColor Red
    Write-Host "Update Windows ou installe PowerShell 7+ depuis github.com/PowerShell/PowerShell" -ForegroundColor Red
    try { [void](Read-Host "Press Enter to close") } catch {}
    exit 2
}

# === CONFIGURATION ===
$InstallerVersion = "0.1.0"
$ScriptDir        = $PSScriptRoot
$ManifestPath     = Join-Path $ScriptDir "manifest.json"

# === HELPERS ===

function Write-Step { param([string]$Msg) Write-Host "[*] $Msg" -ForegroundColor Cyan }
function Write-Ok   { param([string]$Msg) Write-Host "    OK  $Msg" -ForegroundColor Green }
function Write-Warn { param([string]$Msg) Write-Host "    !!  $Msg" -ForegroundColor Yellow }
function Write-Info { param([string]$Msg) Write-Host "        $Msg" -ForegroundColor DarkGray }
function Write-Err  { param([string]$Msg) Write-Host "    XX  $Msg" -ForegroundColor Red }

function Get-MccBuildDetected {
    # Scanne les chemins Steam usuels pour build_tag.txt
    # Retourne @{ build = "..."; path = "..." } ou $null
    $candidates = @(
        "D:\steam\steamapps\common\Halo The Master Chief Collection\build_tag.txt",
        "C:\Program Files (x86)\Steam\steamapps\common\Halo The Master Chief Collection\build_tag.txt",
        "E:\SteamLibrary\steamapps\common\Halo The Master Chief Collection\build_tag.txt",
        "F:\SteamLibrary\steamapps\common\Halo The Master Chief Collection\build_tag.txt"
    )
    foreach ($p in $candidates) {
        if (Test-Path $p) {
            try {
                $build = (Get-Content $p -TotalCount 1 -ErrorAction Stop).Trim()
                return @{ build = $build; path = $p }
            } catch {}
        }
    }
    return $null
}

function Get-FileSha256 {
    param([string]$Path)
    return (Get-FileHash -Path $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Get-IsoTimestamp {
    return (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
}

function Write-LogEntry {
    param(
        [string]$LogPath,
        [string]$Level,
        [string]$Message
    )
    # Logging best-effort : un échec d'écriture log ne doit jamais bloquer l'install
    try {
        $ts = Get-IsoTimestamp
        $line = "[$ts] [$Level] $Message"
        Add-Content -Path $LogPath -Value $line -Encoding UTF8 -ErrorAction Stop
    } catch {
        # Silent fallback
    }
}

# === MAIN ===

$installFailed  = $false
$logPath        = $null
$installedCount = 0

try {
    Write-Host ""
    Write-Host "HaloRP Game Pack Installer v$InstallerVersion" -ForegroundColor Magenta
    Write-Host ("=" * 60) -ForegroundColor Magenta

    # 1. Lecture du manifest
    Write-Step "Lecture du manifest"
    if (-not (Test-Path $ManifestPath)) {
        throw "manifest.json introuvable dans '$ScriptDir'. Le pack semble corrompu — re-télécharge depuis Discord."
    }
    $manifest = Get-Content $ManifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
    Write-Ok "Pack     : $($manifest.pack_name) v$($manifest.version)"
    Write-Ok "Released : $($manifest.released)"

    $payload = if ($manifest.payload) { @($manifest.payload) } else { @() }
    Write-Info "Payload  : $($payload.Count) fichier(s) déclaré(s)"

    # 2. Résolution dossier cible + safety check
    Write-Step "Résolution du dossier cible MCC"
    if ($manifest.target_dir_env -ne "USERPROFILE") {
        throw "target_dir_env inattendu: '$($manifest.target_dir_env)'. Seul 'USERPROFILE' est supporté pour la sécurité."
    }
    $baseDir = Join-Path $env:USERPROFILE ($manifest.target_dir_path -replace '/', '\')
    # Sécurité : le path doit cibler LocalLow\MCC, sinon refus catégorique (anti-manifest malveillant)
    if ($baseDir -notmatch 'LocalLow\\MCC\\') {
        throw "Sécurité: target_dir_path hors LocalLow\MCC refusé. Path résolu: $baseDir"
    }
    Write-Ok "Cible: $baseDir"

    $logPath = Join-Path $baseDir "halorp_install.log"

    # 3. Détection MCC + vérif build
    Write-Step "Détection de MCC"
    $mccInfo = Get-MccBuildDetected
    if (-not $mccInfo) {
        throw "MCC introuvable. Vérifie ton install Steam de 'Halo: The Master Chief Collection'."
    }
    Write-Ok "MCC trouvé   : $($mccInfo.path)"
    Write-Info "Build local  : $($mccInfo.build)"
    Write-Info "Build requis : $($manifest.min_mcc_build)"

    if ($mccInfo.build -ne $manifest.min_mcc_build) {
        $mismatchMsg = "Build MCC mismatch. Local='$($mccInfo.build)' Requis='$($manifest.min_mcc_build)'"
        if ($IgnoreMccBuildMismatch) {
            Write-Warn $mismatchMsg
            Write-Warn "Override -IgnoreMccBuildMismatch actif — installation poursuit."
        } else {
            throw "$mismatchMsg`n`nSolutions :`n  1. Mets MCC à jour via Steam (vérification fichiers).`n  2. OU relance: .\install.ps1 -IgnoreMccBuildMismatch (si tu sais ce que tu fais)."
        }
    } else {
        Write-Ok "Build MCC compatible"
    }

    # 4. Création des sous-dossiers cibles
    Write-Step "Préparation des sous-dossiers LocalLow"
    foreach ($sub in @("Map_Variants", "Game_Variants")) {
        $p = Join-Path $baseDir $sub
        if (-not (Test-Path $p)) {
            New-Item -ItemType Directory -Path $p -Force | Out-Null
            Write-Info "Créé   : $sub"
        } else {
            Write-Info "Existe : $sub"
        }
    }

    Write-LogEntry -LogPath $logPath -Level "INFO" -Message "Install start: $($manifest.pack_name) v$($manifest.version) (PS$($PSVersionTable.PSVersion))"

    # 5. Boucle d'installation des payloads
    Write-Step "Copie + vérification des payloads"
    if ($payload.Count -eq 0) {
        Write-Warn "Aucun payload dans le manifest — pack vide (smoke-test ou pack en cours de préparation)."
    }
    foreach ($entry in $payload) {
        $srcAbs  = Join-Path $ScriptDir ($entry.src -replace '/', '\')
        $destAbs = Join-Path $baseDir ($entry.dest -replace '/', '\')
        Write-Info "$($entry.src) -> $($entry.dest)"

        if (-not (Test-Path $srcAbs)) {
            throw "Fichier payload manquant dans le pack: $srcAbs"
        }

        # (1) Hash source : détecte corruption transit Discord
        $srcHash = Get-FileSha256 -Path $srcAbs
        if ($srcHash -ne $entry.sha256) {
            throw "SHA256 source mismatch pour '$($entry.src)'. Attendu='$($entry.sha256)' Trouvé='$srcHash'. Pack corrompu — re-télécharge."
        }

        # (2) Hash destination si existe : idempotence
        if (Test-Path $destAbs) {
            $existingHash = Get-FileSha256 -Path $destAbs
            if ($existingHash -eq $entry.sha256) {
                Write-Ok "Déjà installé (hash identique): $($entry.dest)"
                $installedCount++
                continue
            }
            Write-Info "Destination existe avec hash différent — écrasement"
            Write-LogEntry -LogPath $logPath -Level "INFO" -Message "Overwriting (different hash): $($entry.dest)"
        }

        # Assure que le dossier dest existe (au cas où dest contient un sous-chemin)
        $destDir = Split-Path $destAbs -Parent
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }

        # Copie
        Copy-Item -Path $srcAbs -Destination $destAbs -Force

        # (3) Hash post-copie : détecte erreur disque (rare mais arrive sur SSD défaillant)
        $copiedHash = Get-FileSha256 -Path $destAbs
        if ($copiedHash -ne $entry.sha256) {
            Remove-Item $destAbs -Force -ErrorAction SilentlyContinue
            throw "SHA256 post-copie mismatch pour '$($entry.dest)'. Fichier corrompu supprimé. Erreur disque ?"
        }

        $installedCount++
        Write-Ok "Installé + vérifié: $($entry.dest)"
        Write-LogEntry -LogPath $logPath -Level "INFO" -Message "Installed: $($entry.dest) (sha256=$copiedHash)"
    }

    # 6. Succès — récap + post_install_message
    Write-LogEntry -LogPath $logPath -Level "INFO" -Message "Install complete: $installedCount file(s)"

    Write-Host ""
    Write-Host "=== INSTALLATION REUSSIE ===" -ForegroundColor Green
    Write-Host "Pack       : $($manifest.pack_name) v$($manifest.version)"
    Write-Host "Fichiers   : $installedCount installé(s) / $($payload.Count) déclaré(s)"
    Write-Host "Log        : $logPath"
    Write-Host ""
    if ($manifest.post_install_message) {
        Write-Host "Prochaine étape :" -ForegroundColor Cyan
        Write-Host $manifest.post_install_message -ForegroundColor Cyan
        Write-Host ""
    }
}
catch {
    $installFailed = $true
    Write-Host ""
    Write-Host "=== INSTALLATION ECHOUEE ===" -ForegroundColor Red
    Write-Err $_.Exception.Message
    if ($logPath) {
        Write-LogEntry -LogPath $logPath -Level "ERROR" -Message $_.Exception.Message
    }
    Write-Host ""
    Write-Host "Détails techniques (copier dans Discord #bugs-feedback si demandé) :" -ForegroundColor DarkGray
    Write-Host "  Script    : $($MyInvocation.MyCommand.Path)" -ForegroundColor DarkGray
    Write-Host "  PS        : $($PSVersionTable.PSVersion)" -ForegroundColor DarkGray
    Write-Host "  OS        : $([System.Environment]::OSVersion.VersionString)" -ForegroundColor DarkGray
    Write-Host "  StackTrc  :" -ForegroundColor DarkGray
    Write-Host $_.ScriptStackTrace -ForegroundColor DarkGray
    Write-Host ""
}
finally {
    if (-not $NoPause) {
        Write-Host ""
        Write-Host "Appuie sur Entrée pour fermer." -ForegroundColor DarkGray
        try { [void](Read-Host) } catch {}
    }
}

if ($installFailed) { exit 1 } else { exit 0 }
