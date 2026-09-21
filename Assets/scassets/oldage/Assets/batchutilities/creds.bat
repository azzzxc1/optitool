@echo off
title Menu de Creditos Stable v2.0
color 0A

:menu
cls
echo ================================
echo           Creditos
echo ================================
echo 1. Mostrar Creditos
echo 2. Salir
echo.
set /p choice="Selecciona una opcion (1-2): "

if "%choice%"=="1" goto credits
if "%choice%"=="2" goto exit
goto menu

:credits
cls
echo ================================
echo           Creditos
echo ================================
echo.
echo Creditos:
echo.
echo Creador: OptiStudio
echo Ayuda: luisreach17
echo Version de creditos: 2.0 "Chocogaseosa"
echo Version: 2.9 "El Fin se Acerca"
echo Gmail: GMAIL CAIDO
echo.
echo OptiStudio Youtube: https://www.youtube.com/channel/UCwPlfaBfRgrAqPe8rZZmQew
echo.
echo LuisReach17 Youtube: https://www.youtube.com/@luisreach17
echo.
echo LuisReach17 Xbox Gamertag: luisreach15 / https://www.xbox.com/es-ES/play/user/luisreach15
echo.
echo ================================
echo.
pause
goto menu

:exit
cls
echo Saliendo del script...
timeout /t 2 > nul
exit
