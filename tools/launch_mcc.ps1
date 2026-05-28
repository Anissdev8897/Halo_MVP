# HaloRP — Lance MCC via Steam protocol (rejoindre AC OFF dans le launcher MCC manuellement)
# Utilisation : clic droit > Run with PowerShell

Write-Host ""
Write-Host "===== HaloRP - Lancement MCC =====" -ForegroundColor Cyan
Write-Host ""

# Verification rapide
$mccRoot = "D:\steam\steamapps\common\Halo The Master Chief Collection"
if (-not (Test-Path "$mccRoot\mcclauncher.exe")) {
    Write-Host "[KO] mcclauncher.exe introuvable. Verifier l'install MCC." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "[INFO] MCC va se lancer via Steam." -ForegroundColor Yellow
Write-Host ""
Write-Host "RAPPEL :" -ForegroundColor White
Write-Host "  1. Le launcher MCC va apparaitre" -ForegroundColor Gray
Write-Host "  2. COCHER 'Anti-Cheat Disabled' (ou 'Mod Mode' selon version)" -ForegroundColor Yellow
Write-Host "  3. Cliquer Play" -ForegroundColor Gray
Write-Host "  4. Verifier le bandeau 'Anti-Cheat is disabled' au demarrage" -ForegroundColor Gray
Write-Host ""

Write-Host "[GO] Lancement Steam..." -ForegroundColor Green
Start-Process "steam://rungameid/976730"

Write-Host ""
Write-Host "Si Steam ne reagit pas, lancer manuellement : Steam > Bibliotheque > MCC > Jouer" -ForegroundColor Gray
Write-Host ""
