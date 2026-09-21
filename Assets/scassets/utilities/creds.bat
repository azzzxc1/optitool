@echo off

:: Coloca el titulo
title %CD%

:: Coloca el color
color 0A


if not exist "%log_dir%" (
    mkdir "%log_dir%"
)

:: Muestra el menu principal
:MENU
:MENU
cls
echo ================================
echo          Creditos 
echo ================================
echo *1 - Mostrar Creditos
echo *2 - Salir
echo.
echo Esta version sera la ultima realizada en OptiTool
echo Gracias por todo.
echo -Att. Fernando (OptiStudio)
echo.

:: Insercion de opciones
set /p choice="Opcion: "


:: Para los comandos
if "%choice%"=="" goto :MENU
if "%choice%"=="1" goto :Creds
if "%choice%"=="2" goto :Ext
if "%choice%"=="3" goto :Ext
goto :MENU

:: Creditos
:Creds
:Creds
cls
echo ================================
echo           Creditos
echo ================================
echo.
echo Creditos:
echo.
echo Creador: OptiStudio, Luisreach17
echo Version del script: 4.2 "The End." 
echo Gmail: optistudio@hotmail.com
echo.
echo Agracedimientos:
echo OptiJuegos (inspiracion)
echo Optimizar PC v5.6 (bases para OptiTool, programa de OptiJuegos)
echo Luisreach17 (Creador de OptiStudio)
echo Chris Titus (Codigo para el batch, no es oficial)
echo ChatGPT (ayuda con el codigo)
echo.
echo OptiStudio YouTube: https://www.youtube.com/channel/UCwPlfaBfRgrAqPe8rZZmQew
echo.
echo ================================
echo.
pause
goto MENU


:: Para salir del script
:Ext
:Ext
cls
echo Saliendo del script...
timeout /t 2 > nul
exit
