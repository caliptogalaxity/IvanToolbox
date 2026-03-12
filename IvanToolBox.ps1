# --- CONFIGURACION ---
$VersionLocal = "1.0"
$LinkMaestro = "https://raw.githubusercontent.com/caliptogalaxity/IvanToolbox/main/IvanToolBox.ps1"

# --- ACTUALIZACION AMIGABLE ---
function Comprobar-Actualizacion {
    try {
        $web = New-Object System.Net.WebClient
        $codigoRemoto = $web.DownloadString($LinkMaestro)
        if ($codigoRemoto -match '\$VersionLocal = "(.*)"') {
            $vRemota = $Matches[1]
            if ([version]$vRemota -gt [version]$VersionLocal) {
                Write-Host "`n #################################################" -ForegroundColor Yellow
                Write-Host "  NUEVA VERSION DISPONIBLE EN GITHUB ($vRemota)" -ForegroundColor Green
                Write-Host "  Descarga el nuevo archivo para estar al dia."
                Write-Host " #################################################`n" -ForegroundColor Yellow
                Start-Sleep -Seconds 2
            }
        }
    } catch { }
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
    Write-Host "      Version: $VersionLocal | Caseros-Haedo Pro       " -ForegroundColor Gray
    Write-Host "#####################################################" -ForegroundColor Cyan
}

Comprobar-Actualizacion

while ($true) {
    Mostrar-Banner
    Write-Host "`n--- ARCHIVOS Y UTILIDADES ---" -ForegroundColor Cyan
    Write-Host " [1]  WinRAR            -> Abre archivos comprimidos."
    Write-Host " [2]  7-Zip             -> Compresor gratuito y liviano."
    Write-Host " [17] MSI Afterburner  -> Mira temperatura de tu video."
    Write-Host " [18] Revo Uninstaller -> Borra programas sin basura."
    Write-Host " [10] Reparar Tienda   -> Arregla la Microsoft Store."
    
    Write-Host "`n--- INTERNET Y REDES ---" -ForegroundColor Yellow
    Write-Host " [3]  Google Chrome     -> El navegador mas famoso."
    Write-Host " [4]  Brave             -> Navegador que quita anuncios."
    Write-Host " [5]  Firefox           -> Navegador seguro y privado."
    Write-Host " [8]  Telegram          -> Mensajeria rapida para PC."
    Write-Host " [9]  Discord           -> Habla mientras juegas."
    
    Write-Host "`n--- JUEGOS Y DIVERSION ---" -ForegroundColor Green
    Write-Host " [6]  Steam             -> La tienda de juegos mas grande."
    Write-Host " [7]  Epic Games        -> Juegos gratis cada semana."
    Write-Host " [13] RetroArch        -> Consola para juegos viejos."
    Write-Host " [14] Mesen            -> El mejor emulador NES/GB."
    Write-Host " [15] Roblox           -> Mundos para jugar y crear."
    Write-Host " [12] BlueStacks       -> Usa apps de celular en PC."
    
    Write-Host "`n--- SEGURIDAD Y NUBE ---" -ForegroundColor Magenta
    Write-Host " [11] Kaspersky Free   -> Antivirus potente y liviano."
    Write-Host " [16] pCloud           -> Disco en internet para fotos."
    
    Write-Host "`n [19] SALIR" -ForegroundColor Red
    Write-Host "=====================================================" -ForegroundColor Cyan
    
    $op = Read-Host "Selecciona una opcion"

    if ($op -eq "19") { exit }
    if ($op -eq "10") {
        wsreset.exe
        Write-Host "Tienda reiniciada." -ForegroundColor Green
        Pause ; continue
    }

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
        Read-Host "Enter para volver..."
    } else {
        Write-Host "Opcion invalida." -ForegroundColor Red
        Start-Sleep -Seconds 1
    }
}
