@echo off
title Sysinfo Stable v2.0
color 0A

:menu
cls
echo ================================
echo       Menu Principal
echo ================================
echo 1. Mostrar Informacion del Sistema
echo 2. Salir
echo.
set /p choice="Opcion: "

if "%choice%"=="1" goto info
if "%choice%"=="2" exit
goto menu

:info
cls
echo ================================
echo     Informacion del Sistema
echo ================================
echo.
echo.
systeminfo
echo.
echo.
echo Version de Sysinfo: v2.0
echo.
echo Presiona cualquier tecla para volver al menu...
pause >nul
goto menu
