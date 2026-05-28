<#
.SYNOPSIS
    Package un Game Pack HaloRP en ZIP avec manifest.json SHA256, prêt distribution Discord.

.DESCRIPTION
    Walks le dossier gamepack, détecte les payloads (.mvar / .bin),
    calcule SHA256 + taille, met à jour (ou crée) manifest.json,
    puis zippe le dossier complet vers dist/ avec timestamp.

    Compatible PowerShell 5.1 (Win10/11 default) et PowerShell 7+.

.PARAMETER GamepackDir
    Chemin vers le dossier gamepack à packager.
    Le dossier doit se terminer par '_v<X.Y[.Z]>'.

.PARAMETER OutputDir
    Dossier de sortie du ZIP. Par défaut: <project_root>/dist/

.PARAMETER DryRun
    Si présent, met à jour manifest.json mais ne crée PAS le ZIP.

.PARAMETER Force
    Si présent, écrase un ZIP existant sans demander.

.EXAMPLE
    .\package_gamepack.ps1 ..\gamepacks\halo_reach_mvp_v0.1

.EXAMPLE
    .\package_gamepack.ps1 ..\gamepacks\halo_reach_mvp_v0.1 -DryRun

.EXAMPLE
    .\package_gamepack.ps1 -GamepackDir ..\gamepacks\halo_reach_mvp_v0.1 -OutputDir D:\releases -Force

.NOTES
    Projet : HaloRP MVP
    Date   : 2026-05-28
    Voir   : configs/forge_label_convention.md, gamepacks/halo_reach_mvp_v0.1/manifest.md
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$GamepackDir,

    [Parameter(Mandatory = $false)]
    [string]$OutputDir,

    [switch]$DryRun,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

# === CONFIGURATION ===
$PackagerVersion = "0.1.0"
$ProjectRoot     = Split-Path $PSScriptRoot -Parent
if (-not $OutputDir) {
    $OutputDir = Join-Path $ProjectRoot "dist"
}

# === HELPERS ===

function Write-Step { param([string]$Msg) Write-Host "[*] $Msg" -ForegroundColor Cyan }
function Write-Ok   { param([string]$Msg) Write-Host "    OK  $Msg" -ForegroundColor Green }
function Write-Warn { param([string]$Msg) Write-Host "    !!  $Msg" -ForegroundColor Yellow }
function Write-Info { param([string]$Msg) Write-Host "        $Msg" -ForegroundColor DarkGray }

function Get-PackVersionFromFolder {
    param([string]$FolderName)
    if ($FolderName -match '_v(\d+(?:\.\d+){0,3})$') {
        return $Matches[1]
    }
    throw "Format de dossier non reconnu: '$FolderName'. Attendu suffixe '_v<X[.Y[.Z]]>' (ex: halo_reach_mvp_v0.1)."
}

function Get-DestinationFor {
    param([string]$FileName)
    $ext = [System.IO.Path]::GetExtension($FileName).ToLowerInvariant()
    switch ($ext) {
        '.mvar' { return "Map_Variants/$FileName" }
        '.bin'  { return "Game_Variants/$FileName" }
        default { return $null }
    }
}

function Get-MccBuildDetected {
    # MCC écrit son build dans build_tag.txt à la racine de l'install.
    # On scanne les chemins Steam usuels — fallback "unknown" si introuvable.
    $candidates = @(
        "D:\steam\steamapps\common\Halo The Master Chief Collection\build_tag.txt",
        "C:\Program Files (x86)\Steam\steamapps\common\Halo The Master Chief Collection\build_tag.txt",
        "E:\SteamLibrary\steamapps\common\Halo The Master Chief Collection\build_tag.txt"
    )
    foreach ($p in $candidates) {
        if (Test-Path $p) {
            try {
                # build_tag.txt peut contenir plusieurs lignes — on prend la 1ère (canonique)
                return (Get-Content $p -TotalCount 1 -ErrorAction Stop).Trim()
            } catch {}
        }
    }
    return "unknown"
}

function Get-IsoTimestamp {
    return (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
}

function Get-FileSha256 {
    param([string]$Path)
    return (Get-FileHash -Path $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

function ConvertTo-RelativePath {
    param(
        [string]$BasePath,
        [string]$FullPath
    )
    $baseNorm = $BasePath.TrimEnd('\', '/')
    return $FullPath.Substring($baseNorm.Length + 1) -replace '\\', '/'
}

function Write-JsonUtf8NoBom {
    param(
        [string]$Path,
        [string]$Content
    )
    # PowerShell 5.1 écrit UTF-16 LE BOM par défaut sur Set-Content.
    # On force UTF-8 sans BOM via .NET pour compat parsers stricts (Node, GAS).
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $Content, $utf8)
}

# === MAIN ===

Write-Host ""
Write-Host "HaloRP Game Pack Packager v$PackagerVersion" -ForegroundColor Magenta
Write-Host ("=" * 60) -ForegroundColor Magenta

# 1. Résolution & validation du dossier gamepack
Write-Step "Validation du dossier gamepack"
$resolved = Resolve-Path -Path $GamepackDir -ErrorAction SilentlyContinue
if (-not $resolved) {
    throw "Dossier introuvable: $GamepackDir"
}
$GamepackDir = $resolved.Path.TrimEnd('\', '/')
if (-not (Test-Path $GamepackDir -PathType Container)) {
    throw "Le chemin existe mais n'est pas un dossier: $GamepackDir"
}

$folderName  = Split-Path $GamepackDir -Leaf
$packVersion = Get-PackVersionFromFolder -FolderName $folderName
$packName    = $folderName -replace '_v\d+(?:\.\d+){0,3}$', ''

Write-Ok "Pack name : $packName"
Write-Ok "Version   : $packVersion"
Write-Ok "Dossier   : $GamepackDir"

# 2. Détection des payloads (.mvar / .bin)
Write-Step "Détection des fichiers payload"
$payloadFiles = @(
    Get-ChildItem -Path $GamepackDir -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.Extension -in '.mvar', '.bin' }
)

if ($payloadFiles.Count -eq 0) {
    Write-Warn "Aucun fichier .mvar ou .bin détecté."
    Write-Info "Le pack sera packagé sans payload — smoke-test OK, mais install.ps1 ne pourra rien copier."
} else {
    Write-Ok "$($payloadFiles.Count) fichier(s) payload détecté(s)"
    foreach ($f in $payloadFiles) {
        $sizeKb = [math]::Round($f.Length / 1KB, 1)
        Write-Info ("- {0} ({1} KB)" -f $f.Name, $sizeKb)
    }
}

# 3. Calcul des SHA256 + génération des entrées manifest
Write-Step "Calcul des hashes SHA256"
$payloadEntries = @()
foreach ($f in $payloadFiles) {
    $relSrc = ConvertTo-RelativePath -BasePath $GamepackDir -FullPath $f.FullName
    $dest   = Get-DestinationFor -FileName $f.Name
    if (-not $dest) {
        Write-Warn "Extension inattendue '$($f.Extension)' pour $($f.Name) — ignoré"
        continue
    }
    $hash = Get-FileSha256 -Path $f.FullName
    $payloadEntries += [PSCustomObject][ordered]@{
        src        = $relSrc
        dest       = $dest
        sha256     = $hash
        size_bytes = $f.Length
    }
    Write-Info "$($f.Name) -> $($hash.Substring(0, 16))..."
}

# 4. Lecture du manifest existant (pour préserver post_install_message custom)
Write-Step "Mise à jour de manifest.json"
$manifestPath = Join-Path $GamepackDir "manifest.json"
$existing = $null
if (Test-Path $manifestPath) {
    try {
        $existing = Get-Content $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
        Write-Ok "Manifest existant lu (version précédente: $($existing.version))"
    } catch {
        Write-Warn "manifest.json existant invalide — sera réécrit. ($($_.Exception.Message))"
    }
} else {
    Write-Info "Manifest absent — création depuis template"
}

$postInstallMsg = if ($existing -and $existing.post_install_message) {
    $existing.post_install_message
} else {
    "Lance MCC via Steam, coche Anti-Cheat OFF, Custom Games -> charge la map FOB Alpha + la variante Sentinel-Defense v1."
}

$manifest = [PSCustomObject][ordered]@{
    pack_name            = $packName
    version              = $packVersion
    released             = Get-IsoTimestamp
    packager_version     = $PackagerVersion
    min_mcc_build        = Get-MccBuildDetected
    target_dir_env       = "USERPROFILE"
    target_dir_path      = "AppData/LocalLow/MCC/Temporary/UserContent/HaloReach"
    payload              = $payloadEntries
    post_install_message = $postInstallMsg
}

$json = $manifest | ConvertTo-Json -Depth 6
Write-JsonUtf8NoBom -Path $manifestPath -Content $json
Write-Ok "manifest.json écrit ($($json.Length) bytes UTF-8 no-BOM)"

# 5. Vérifications pré-zip
Write-Step "Vérifications pré-zip"
$installScript = Join-Path $GamepackDir "install.ps1"
if (Test-Path $installScript) {
    Write-Ok "install.ps1 présent — sera inclus dans le ZIP"
} else {
    Write-Warn "install.ps1 absent — ZIP produit sans installeur."
    Write-Info "Crée install.ps1 dans le gamepack avant la distribution Discord (artefact #2 du backlog)."
}

# 6. DryRun: sortie anticipée
if ($DryRun) {
    Write-Host ""
    Write-Host "[DRY-RUN] manifest mis à jour, ZIP non produit." -ForegroundColor Yellow
    Write-Host "Re-lance sans -DryRun pour produire l'archive." -ForegroundColor Yellow
    return
}

# 7. Création du ZIP via .NET (top-level dir = nom du gamepack)
Write-Step "Création du ZIP"
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    Write-Info "Dossier de sortie créé: $OutputDir"
}

$timestamp = (Get-Date).ToString("yyyyMMdd-HHmm")
$zipName   = "${packName}_v${packVersion}_${timestamp}.zip"
$zipPath   = Join-Path $OutputDir $zipName

if (Test-Path $zipPath) {
    if ($Force) {
        Remove-Item $zipPath -Force
        Write-Info "Ancien ZIP écrasé (-Force)"
    } else {
        throw "Le ZIP existe déjà: $zipPath. Utilise -Force pour écraser."
    }
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory(
    $GamepackDir,
    $zipPath,
    [System.IO.Compression.CompressionLevel]::Optimal,
    $true  # includeBaseDirectory = top-level du zip = nom du gamepack
)

$zipInfo   = Get-Item $zipPath
$zipSizeKb = [math]::Round($zipInfo.Length / 1KB, 1)
$zipSha    = Get-FileSha256 -Path $zipPath
Write-Ok "ZIP créé: $zipName"
Write-Info "Path     : $zipPath"
Write-Info ("Taille   : {0} KB" -f $zipSizeKb)
Write-Info "SHA256   : $zipSha"

# 8. Récapitulatif final
Write-Host ""
Write-Host "=== RÉCAP ===" -ForegroundColor Magenta
Write-Host "Pack         : $packName v$packVersion"
Write-Host "Released     : $($manifest.released)"
Write-Host "MCC build    : $($manifest.min_mcc_build)"
Write-Host "Payload      : $($payloadEntries.Count) fichier(s)"
foreach ($e in $payloadEntries) {
    $kb = [math]::Round($e.size_bytes / 1KB, 1)
    Write-Host ("  {0,-40} {1,8} KB  {2}..." -f $e.dest, $kb, $e.sha256.Substring(0, 16))
}
Write-Host "ZIP          : $zipPath"
Write-Host ("Taille ZIP   : {0} KB" -f $zipSizeKb)
Write-Host "ZIP SHA256   : $zipSha"
Write-Host ""
Write-Host "Prêt à poster dans Discord #downloads." -ForegroundColor Green
Write-Host ""
