@echo off
title RobLauncher Downloader
color 0A
setlocal

:: Definir el enlace y la ubicación de descarga
set OUTPUT_DIR=%~dp0\Downloaded
set WGET=%~dp0wget.exe
:: Crear la carpeta Downloaded si no existe
if not exist "%OUTPUT_DIR%" (
    mkdir "%OUTPUT_DIR%"
)

:Menu
:Menu
cls
echo ================================
echo       Menu Principal
echo ================================
echo 1 - Descargar RobLauncher
echo 2 - Salir
echo.
set /p choice="Opcion: "

if "%choice%"=="1" goto Download
if "%choice%"=="2" exit

echo Opcion no valida. Intenta de nuevo.
pause
goto menu

:Download
:Download
cls
echo ================================
echo     Descargando RobLauncher
echo ================================
echo.

%WGET% -q --no-check-certificate --show-progress --connect-timeout=15 --tries=3 -P "%~dp0Downloaded" "https://raw.githubusercontent.com/OptiJuegos/RobLauncher/releases/download/1.91/RobLauncher.Release.V1.91.zip"

echo.
echo Presiona cualquier tecla para volver al menu...
pause >nul
goto menu
