# --- CONFIGURACION DE VERSION ---
$VersionLocal = "3.2026:2"
$LinkMaestro = "https://raw.githubusercontent.com/caliptogalaxity/IvanToolbox/main/IvanToolBox.ps1"

# --- LOGICA DE ACTUALIZACION ---
function Comprobar-Actualizacion {
    try {
        $web = New-Object System.Net.WebClient
        $codigoRemoto = $web.DownloadString($LinkMaestro)
        if ($codigoRemoto -match '\$VersionLocal = "(.*)"') {
            $vRemota = $Matches[1]
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
    Write-Host "`n[+] Iniciando mantenimiento preventivo..." -ForegroundColor Cyan
    $rutas = @("C:\Windows\Temp\*", "$env:TEMP\*", "C:\Windows\Prefetch\*")
    foreach ($ruta in $rutas) {
        Write-Host " > Limpiando archivos residuales: $ruta" -ForegroundColor Gray
        Remove-Item -Path $ruta -Recurse -Force -ErrorAction SilentlyContinue
    }
    Write-Host "[+] Vaciando papelera de reciclaje..." -ForegroundColor Cyan
    Clear-RecycleBin -Force -ErrorAction SilentlyContinue
    Write-Host "[+] Optimizando bloques de memoria RAM..." -ForegroundColor Cyan
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    Write-Host "`n¡MANTENIMIENTO FINALIZADO CON EXITO!" -ForegroundColor Green
    Pause
}

# --- PRIVILEGIOS ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

function Mostrar-Menu {
    Clear-Host
    Write-Host "#####################################################" -ForegroundColor Cyan
    Write-Host "      IVAN TOOLBOX | SOPORTE TECNICO PROFESIONAL     " -ForegroundColor White -BackgroundColor DarkMagenta
    Write-Host "      Revision: $VersionLocal | Zona Oeste Pro       " -ForegroundColor Gray
    Write-Host "#####################################################" -ForegroundColor Cyan
    
    Write-Host "`n--- [ SERVICIOS DE MANTENIMIENTO ] ---" -ForegroundColor Yellow
    Write-Host " [1] LIMPIEZA TOTAL      -> Elimina basura, temporales y libera RAM."
    Write-Host " [2] REPARAR TIENDA      -> Soluciona errores de la Microsoft Store."
    Write-Host " [3] REVO UNINSTALLER    -> Desinstalacion limpia sin dejar rastros."

    Write-Host "`n--- [ COMPLEMENTOS DE SISTEMA ] ---" -ForegroundColor Yellow
    Write-Host " [20] MICROSOFT OFFICE   -> Suite completa (Word, Excel, PowerPoint)."
    Write-Host " [21] LIBRERIAS RUNTIMES -> Visual C++ y DirectX (Para juegos y DLLs)."

    Write-Host "`n--- [ NAVEGACION E INTERNET ] ---" -ForegroundColor Cyan
    Write-Host " [4] GOOGLE CHROME       -> El navegador mas rapido y compatible."
    Write-Host " [5] BRAVE BROWSER       -> Privacidad extrema y bloqueo de avisos."
    Write-Host " [6] MOZILLA FIREFOX     -> Navegador seguro de codigo abierto."
    Write-Host " [7] TELEGRAM DESKTOP    -> Mensajeria segura con nube ilimitada."
    Write-Host " [8] DISCORD             -> La mejor plataforma de chat y voz."

    Write-Host "`n--- [ JUEGOS Y EMULACION ] ---" -ForegroundColor Green
    Write-Host " [9] STEAM               -> La tienda global de juegos para PC."
    Write-Host " [10] EPIC GAMES         -> Launcher oficial con juegos gratuitos."
    Write-Host " [11] RETROARCH          -> El emulador definitivo multiconsola."
    Write-Host " [12] MESEN              -> Emulador de alta precision para NES/GB."
    Write-Host " [13] ROBLOX             -> Plataforma de juegos y creacion 3D."
    Write-Host " [14] BLUESTACKS         -> El mejor emulador de Android en PC."

    Write-Host "`n--- [ HERRAMIENTAS Y SEGURIDAD ] ---" -ForegroundColor Magenta
    Write-Host " [15] KASPERSKY FREE     -> Proteccion avanzada contra amenazas."
    Write-Host " [16] PCLOUD DRIVE       -> Almacenamiento seguro en la nube."
    Write-Host " [17] MSI AFTERBURNER    -> Control y monitoreo de hardware/GPU."
    Write-Host " [18] WINRAR             -> Gestion de archivos comprimidos .rar"
    Write-Host " [19] 7-ZIP              -> Alternativa libre para archivos .zip"

    Write-Host "`n [0] SALIR DEL PROGRAMA" -ForegroundColor Red
    Write-Host "=====================================================" -ForegroundColor Cyan
}

Comprobar-Actualizacion

while ($true) {
    Mostrar-Menu
    $op = Read-Host "`nSeleccione el numero de la utilidad"

    switch ($op) {
        "0"  { exit }
        "1"  { Ejecutar-Mantenimiento }
        "2"  { wsreset.exe; Write-Host "Tienda reiniciada."; Pause }
        "3"  { winget install --id RevoSolution.RevoUninstaller --silent; Pause }
        "20" { 
                Write-Host "`n> Instalando Microsoft Office..." -ForegroundColor Cyan
                winget install --id Microsoft.Office --silent --accept-package-agreements --accept-source-agreements
                Write-Host "LISTO!" -ForegroundColor Green
                Pause 
             }
        "21" { 
                Write-Host "`n> Instalando Librerias Criticas (Visual C++ y DirectX)..." -ForegroundColor Cyan
                winget install --id Microsoft.VCRedist.2015+.x64 --silent --accept-package-agreements
                winget install --id Microsoft.DirectX --silent --accept-package-agreements
                Write-Host "SISTEMA ACTUALIZADO CON LIBRERIAS ESENCIALES." -ForegroundColor Green
                Pause 
             }
        "4"  { winget install --id Google.Chrome --silent; Pause }
        "5"  { winget install --id Brave.Brave --silent; Pause }
        "6"  { winget install --id Mozilla.Firefox --silent; Pause }
        "7"  { winget install --id Telegram.TelegramDesktop --silent; Pause }
        "8"  { winget install --id Discord.Discord --silent; Pause }
        "9"  { winget install --id Valve.Steam --silent; Pause }
        "10" { winget install --id EpicGames.EpicGamesLauncher --silent; Pause }
        "11" { winget install --id Libretro.RetroArch --silent; Pause }
        "12" { winget install --id SourMesen.Mesen --silent; Pause }
        "13" { winget install --id Roblox.Roblox --silent; Pause }
        "14" { winget install --id BlueStack.BlueStacks --silent; Pause }
        "15" { winget install --id Kaspersky.Kaspersky --silent; Pause }
        "16" { winget install --id pCloud.pCloudDrive --silent; Pause }
        "17" { winget install --id MSI.Afterburner --silent; Pause }
        "18" { winget install --id RARLab.WinRAR --silent; Pause }
        "19" { winget install --id 7zip.7zip --silent; Pause }
        Default { Write-Host "Opcion no valida." -ForegroundColor Red; Start-Sleep -Seconds 1 }
    }
}
