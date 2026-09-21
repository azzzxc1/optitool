@echo off
cls
set LAUNCH_TIT=%~dp0

:: Coloca la version como titulo
title %LAUNCH_TIT%

:: Coloca el color
color 0A

:: Comprobamos si el script tiene permisos de administrador
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    :: Si no tiene permisos de administrador, solicitar permisos de administrador
    goto :RequestAdmin
) else (
    :: Si tiene permisos de administrador, ir a :Admin
    goto :Admin
)

:RequestAdmin
:: Solicitar permisos de administrador mediante UAC solo si no los tiene
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd.exe", "/c ""%~s0""", "", "runas", 1 >> "%temp%\getadmin.vbs"

:: Ejecutar el script con permisos de administrador
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"

:: Si el UAC fue rechazado, el script no tendrá permisos y irá a :NoAdmin
exit /b

:Admin
:: Verificar nuevamente si tenemos permisos
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    :: Si no tiene permisos, ir a :NoAdmin
    goto :NoAdmin
) else (
    :: Si tiene permisos, ir a :RunMain
    goto :RunMain
)

:NoAdmin
:: Si no tiene permisos de administrador
timeout /t 1 /nobreak>nul
exit

:RunMain
:: Ejecutar el script principal sin abrir una nueva ventana de CMD
start /B "" "%~dp0Assets\main.cmd"
exit /B
