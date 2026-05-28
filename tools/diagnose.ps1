# HaloRP MVP - Diagnostic d'install MCC
# Utilisation : clic droit > Run with PowerShell, ou : powershell -File diagnose.ps1

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "===== HaloRP MVP - Diagnostic MCC =====" -ForegroundColor Cyan
Write-Host ""

# 1. MCC install
$mccRoot = "D:\steam\steamapps\common\Halo The Master Chief Collection"
if (Test-Path $mccRoot) {
    Write-Host "[OK] MCC install  : $mccRoot" -ForegroundColor Green
}
else {
    Write-Host "[KO] MCC install introuvable a $mccRoot" -ForegroundColor Red
    Write-Host "     Modifier le script si install ailleurs."
    exit 1
}

# 2. mcclauncher.exe
$launcher = Join-Path $mccRoot "mcclauncher.exe"
if (Test-Path $launcher) {
    Write-Host "[OK] mcclauncher  : present" -ForegroundColor Green
}
else {
    Write-Host "[KO] mcclauncher.exe absent" -ForegroundColor Red
}

# 3. Reach pack
$reach = Join-Path $mccRoot "haloreach"
if (Test-Path $reach) {
    $mapCount = (Get-ChildItem (Join-Path $reach "maps") -Filter "*.map" -ErrorAction SilentlyContinue).Count
    $variantCount = (Get-ChildItem (Join-Path $reach "game_variants") -Filter "*.bin" -ErrorAction SilentlyContinue).Count
    Write-Host "[OK] Halo Reach   : $mapCount maps, $variantCount variantes officielles" -ForegroundColor Green
}
else {
    Write-Host "[KO] Halo Reach pack absent - installer via MCC launcher" -ForegroundColor Red
}

# 4. Easy Anti-Cheat
$eac = Join-Path $mccRoot "easyanticheat"
if (Test-Path $eac) {
    Write-Host "[OK] EAC config   : present (mode AC OFF disponible)" -ForegroundColor Green
}
else {
    Write-Host "[--] EAC config absent - verifier integrite Steam" -ForegroundColor Yellow
}

# 5. Build version
$buildTag = Join-Path $mccRoot "build_tag.txt"
if (Test-Path $buildTag) {
    $build = Get-Content $buildTag -Raw
    Write-Host "[OK] Build MCC    : $($build.Trim())" -ForegroundColor Green
}

Write-Host ""

# 6. UserContent folders
$userContent = Join-Path $env:USERPROFILE "AppData\LocalLow\MCC\Temporary\UserContent\HaloReach"
$folders = @("Map_Variants", "Game_Variants", "Screenshots", "Films")

if (Test-Path $userContent) {
    Write-Host "[OK] UserContent  : $userContent" -ForegroundColor Green
    foreach ($f in $folders) {
        $path = Join-Path $userContent $f
        if (Test-Path $path) {
            $count = (Get-ChildItem $path -ErrorAction SilentlyContinue).Count
            Write-Host "     - ${f}: $count fichiers" -ForegroundColor Gray
        }
        else {
            Write-Host "     - ${f}: absent (creation...)" -ForegroundColor Yellow
            New-Item -ItemType Directory -Path $path -Force | Out-Null
            Write-Host "       cree" -ForegroundColor Green
        }
    }
}
else {
    Write-Host "[--] UserContent absent (lancer MCC une fois pour le creer)" -ForegroundColor Yellow
    Write-Host "     Creation manuelle en cours..."
    foreach ($f in $folders) {
        New-Item -ItemType Directory -Path (Join-Path $userContent $f) -Force | Out-Null
    }
    Write-Host "[OK] UserContent  : cree" -ForegroundColor Green
}

Write-Host ""

# 7. Steam Cloud detection
$steamUserdata = "C:\Program Files (x86)\Steam\userdata"
if (Test-Path $steamUserdata) {
    $mccCloudUsers = @()
    Get-ChildItem $steamUserdata -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        if (Test-Path (Join-Path $_.FullName "976730")) { $mccCloudUsers += $_.Name }
    }
    if ($mccCloudUsers.Count -gt 0) {
        Write-Host "[OK] Steam Cloud  : MCC detecte pour user(s) : $($mccCloudUsers -join ', ')" -ForegroundColor Green
    }
    else {
        Write-Host "[--] Steam Cloud  : pas de save MCC (lancer MCC une fois)" -ForegroundColor Yellow
    }
}

Write-Host ""

# 8. Summary
Write-Host "===== Recap pratique =====" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ou placer tes .mvar (Forge maps custom) :" -ForegroundColor White
Write-Host "  $userContent\Map_Variants\" -ForegroundColor Yellow
Write-Host ""
Write-Host "Ou placer tes .bin (Custom Game variants) :" -ForegroundColor White
Write-Host "  $userContent\Game_Variants\" -ForegroundColor Yellow
Write-Host ""
Write-Host "Lancer MCC :" -ForegroundColor White
Write-Host "  Steam puis MCC puis Play, cocher 'Anti-Cheat Disabled' dans le launcher." -ForegroundColor Yellow
Write-Host ""
