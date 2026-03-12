# --- CONFIGURACION DE VERSION ---
# Formato sugerido por Iván: Mes.Año:Correlativo
$VersionLocal = "3.2026:1"
$LinkMaestro = "https://raw.githubusercontent.com/caliptogalaxity/IvanToolbox/main/IvanToolBox.ps1"

# --- LOGICA DE ACTUALIZACION ---
function Comprobar-Actualizacion {
    try {
        $web = New-Object System.Net.WebClient
        $codigoRemoto = $web.DownloadString($LinkMaestro)
        if ($codigoRemoto -match '\$VersionLocal = "(.*)"') {
            $vRemota = $Matches[1]
            # Limpiamos caracteres para comparar como números
            $vRemotaNum = $vRemota -replace '[:\.]', ''
            $vLocalNum = $VersionLocal -replace '[:\.]', ''
            
            if ([long]$vRemotaNum -gt [long]$vLocalNum) {
                Write-Host "`n #################################################" -ForegroundColor Yellow
                Write-Host "  NUEVA ACTUALIZACION DISPONIBLE: $vRemota" -ForegroundColor Green
                Write-Host "  Descarga el nuevo codigo para estar al dia."
                Write-Host " #################################################`n" -ForegroundColor Yellow
                Start-Sleep -Seconds 3
            }
        }
    } catch { }
}

# --- FUNCION DE MANTENIMIENTO ---
function Ejecutar-Mantenimiento {
    Write-Host "`n[+] Iniciando limpieza profunda de basura..." -ForegroundColor Cyan
    $rutas = @("C:\Windows\Temp\*", "$env:TEMP\*", "C:\Windows\Prefetch\*")
    foreach ($ruta in $rutas) {
        Write-Host " > Eliminando rastros en: $ruta" -ForegroundColor Gray
        Remove-Item -Path $ruta -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Host "[+] Vaciando Papelera de Reciclaje..." -ForegroundColor Cyan
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    
    Write-Host "[+] Optimizando Memoria RAM..." -ForegroundColor Cyan
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    
    Write-Host "`n¡SISTEMA OPTIMIZADO PARA CASEROS-HAEDO!" -ForegroundColor Green
    Pause
}

# --- ELEVACION ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

function Mostrar-Banner {
    Clear-Host
    Write-Host "#####################################################" -ForegroundColor Cyan
    Write-Host "      IVAN TOOLBOX: EL KIT DEFINITIVO PARA TU PC     " -ForegroundColor White -BackgroundColor DarkMagenta
    Write-Host "      Revision: $VersionLocal | Zona Oeste Pro       " -ForegroundColor Gray
    Write-Host "#####################################################" -ForegroundColor Cyan
}

Comprobar-Actualizacion

while ($true) {
    Mostrar-Banner
    Write-Host "`n--- MANTENIMIENTO ---" -ForegroundColor Yellow
    Write-Host " [20] LIMPIEZA TOTAL (Temp, Basura y RAM)" -ForegroundColor Yellow -BackgroundColor Black
    Write-Host " [10] Reparar Tienda Microsoft"
    Write-Host " [18] Revo Uninstaller (Desinstalador Pro)"

    Write-Host "`n--- INTERNET Y REDES ---" -ForegroundColor Yellow
    Write-Host " [3] Chrome  [4] Brave  [5] Firefox  [8] Telegram  [9] Discord"

    Write-Host "`n--- JUEGOS Y UTILIDADES ---" -ForegroundColor Green
    Write-Host " [6] Steam  [7] Epic Games  [13] RetroArch  [14] Mesen  [15] Roblox"
    Write-Host " [12] BlueStacks  [17] MSI Afterburner [1] WinRAR [2] 7-Zip"

    Write-Host "`n--- SEGURIDAD Y NUBE ---" -ForegroundColor Magenta
    Write-Host " [11] Kaspersky Free  [16] pCloud"

    Write-Host "`n [19] SALIR" -ForegroundColor Red
    Write-Host "=====================================================" -ForegroundColor Cyan

    $op = Read-Host "Selecciona una opcion"

    if ($op -eq "19") { exit }
    if ($op -eq "20") { Ejecutar-Mantenimiento; continue }
    if ($op -eq "10") { wsreset.exe; Write-Host "Tienda reiniciada."; Pause; continue }

    $appId = switch ($op) {
        "1"  { "RARLab.WinRAR" }
        "2"  { "7zip.7zip" }
        "3"  { "Google.Chrome" }
        "4"  { "Brave.Brave" }
        "5"  { "Mozilla.Firefox" }
        "6"  { "Valve.Steam" }
        "7"  { "EpicGames.EpicGamesLauncher" }
        "8"  { "Telegram.TelegramDesktop" }
        "9"  { "Discord.Discord" }
        "11" { "Kaspersky.Kaspersky" }
        "12" { "BlueStack.BlueStacks" }
        "13" { "Libretro.RetroArch" }
        "14" { "SourMesen.Mesen" }
        "15" { "Roblox.Roblox" }
        "16" { "pCloud.pCloudDrive" }
        "17" { "MSI.Afterburner" }
        "18" { "RevoSolution.RevoUninstaller" }
        Default { $null }
    }

    if ($appId) {
        Write-Host "`n> Instalando: $appId" -ForegroundColor Cyan
        winget install --id $appId --silent --accept-package-agreements --accept-source-agreements
        Write-Host "LISTO!" -ForegroundColor Green
        Pause
    }
}
