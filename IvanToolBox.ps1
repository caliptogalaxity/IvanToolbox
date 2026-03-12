# --- CONFIGURACION DE IDENTIDAD Y VERSION ---
$VersionLocal = "1.0"
$LinkMaestro = "https://raw.githubusercontent.com/caliptogalaxity/IvanToolbox/refs/heads/main/IvanToolBox.ps1" # <--- PEGA TU LINK "RAW" DE GITHUB ACA

# --- FUNCION DE AUTO-ACTUALIZACION ---
function Comprobar-Actualizacion {
    try {
        Write-Host "Comprobando si hay una version mas nueva en el servidor..." -ForegroundColor Cyan
        $CodigoRemoto = Invoke-WebRequest -Uri $LinkMaestro -UseBasicParsing -TimeoutSec 5
        
        # Buscamos la linea de version en el codigo de GitHub
        if ($CodigoRemoto.Content -match '\$VersionLocal = "(.*)"') {
            $VersionRemota = $Matches[1]
            
            if ($VersionRemota -gt $VersionLocal) {
                Write-Host "¡NUEVA VERSION DETECTADA ($VersionRemota)!" -ForegroundColor Green
                Write-Host "Descargando mejoras..." -ForegroundColor Yellow
                $CodigoRemoto.Content | Out-File -FilePath $PSCommandPath -Encoding utf8
                Write-Host "Actualizacion completada con exito. Por favor, abre el programa de nuevo." -ForegroundColor Cyan
                Pause
                exit
            } else {
                Write-Host "Tienes la version mas reciente ($VersionLocal). ¡Todo listo!" -ForegroundColor Gray
                Start-Sleep -Seconds 1
            }
        }
    } catch {
        Write-Host "Aviso: No se pudo chequear actualizaciones (¿tienes internet?)." -ForegroundColor Red
        Start-Sleep -Seconds 2
    }
}

# --- AUTO-ELEVACION A ADMINISTRADOR ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- EJECUTAR ACTUALIZACION AL INICIO ---
Comprobar-Actualizacion

function Mostrar-Banner {
    Clear-Host
    Write-Host "#####################################################" -ForegroundColor Cyan
    Write-Host "      IVAN TOOLBOX: EL KIT DEFINITIVO PARA TU PC     " -ForegroundColor White -BackgroundColor DarkMagenta
    Write-Host "      Version: $VersionLocal | Siempre Actualizado     " -ForegroundColor Gray
    Write-Host "#####################################################" -ForegroundColor Cyan
    Write-Host ""
}

while ($true) {
    Mostrar-Banner
    
    # --- CATEGORIAS ---
    Write-Host "--- 📂 ARCHIVOS Y UTILIDADES ---" -ForegroundColor Cyan
    Write-Host " [1] WinRAR            -> Abre archivos comprimidos (libritos)."
    Write-Host " [2] 7-Zip             -> Similar al WinRAR pero gratis y mas liviano."
    Write-Host " [17] MSI Afterburner  -> Mira la temperatura y potencia de tu placa de video."
    Write-Host " [18] Revo Uninstaller -> Borra programas por completo sin dejar rastro."
    Write-Host " [10] Reparar Tienda   -> Arregla la Microsoft Store si no abre o falla."
    Write-Host ""

    Write-Host "--- 🌐 INTERNET Y REDES ---" -ForegroundColor Yellow
    Write-Host " [3] Google Chrome     -> El navegador mas famoso para entrar a internet."
    Write-Host " [4] Brave             -> Navegador que quita las publicidades molestas."
    Write-Host " [5] Firefox           -> Navegador muy seguro y privado."
    Write-Host " [8] Telegram          -> Mensajeria para chatear y enviar archivos grandes."
    Write-Host " [9] Discord           -> El lugar ideal para hablar con amigos mientras juegas."
    Write-Host ""

    Write-Host "--- 🎮 JUEGOS Y DIVERSION ---" -ForegroundColor Green
    Write-Host " [6] Steam             -> La tienda de juegos mas grande (Counter, CS2, etc)."
    Write-Host " [7] Epic Games        -> Donde regalan juegos gratis todas las semanas."
    Write-Host " [13] RetroArch        -> Consola virtual para jugar miles de juegos viejos."
    Write-Host " [14] Mesen            -> El mejor para jugar juegos de la Family y Game Boy."
    Write-Host " [15] Roblox           -> Millones de mundos para jugar y crear."
    Write-Host " [12] BlueStacks       -> Para usar juegos de celular (Android) en tu PC."
    Write-Host ""

    Write-Host "--- 🛡️ SEGURIDAD Y NUBE ---" -ForegroundColor Magenta
    Write-Host " [11] Kaspersky Free   -> Antivirus muy potente que no traba tu computadora."
    Write-Host " [16] pCloud           -> Un disco rigido en internet para guardar tus fotos."
    Write-Host ""

    Write-Host " [19] SALIR" -ForegroundColor Red
    Write-Host "=====================================================" -ForegroundColor Cyan
    
    $op = Read-Host "Escribe el numero de lo que quieres instalar"

    if ($op -eq "10") {
        Write-Host "`n> Intentando arreglar la tienda de Windows..." -ForegroundColor Yellow
        wsreset.exe
        Write-Host "OK: Se esta reiniciando la tienda. Espera unos segundos." -ForegroundColor Green
        Read-Host "`nPresione Enter para continuar..."
        continue
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
        "19" { exit }
        Default { $null }
    }

    if ($appId) {
        Write-Host "`n> Preparando instalacion de: $appId" -ForegroundColor Cyan
        Write-Host "> Esto puede tardar un poquito dependiendo de tu internet..." -ForegroundColor Gray
        winget install --id $appId --silent --accept-package-agreements --accept-source-agreements
        Write-Host "¡LISTO! El programa ya esta en tu PC." -ForegroundColor Green
        Read-Host "`nPresione Enter para volver al menu..."
    } else {
        if ($op -ne "19") {
            Write-Host "Ups, ese numero no esta en la lista. Intenta de nuevo." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}
