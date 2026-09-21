@echo off
title script
color 0A

:: BatGotAdmin
REM  --> Verificar permisos
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> Si se establece la bandera de error, no tenemos permisos de administrador.
if '%errorlevel%' NEQ '0' (
    goto UACP
) else (
    goto AdminEnable
)

:UACP
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:AdminEnable
    pushd "%CD%"
    CD /D "%~dp0"

:Confirm
:Confirm
cls
set /p option="Sure (Y/N)? "

if /I "%option%"=="Y" goto Upd
if /I "%option%"=="YES" goto Upd
if /I "%option%"=="N" exit
if /I "%option%"=="NO" exit

:Upd
:Upd

:: Obtener la fecha y hora actual
for /f "tokens=2 delims==" %%I in ('"wmic OS Get localdatetime /value"') do set datetime=%%I
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set hour=%datetime:~8,2%
set minute=%datetime:~10,2%

:: Crear variable con la fecha y hora en formato yyyy-mm-dd_hh-mm-ss
set datetime_log=%year%-%month%-%day%_%hour%-%minute%

:: Definir el archivo de log
set "logFile=%~dp0scassets\logs\updaterequest-%datetime_log%.log"

:: Registrar el log de éxito
echo User requested to update script at [%datetime-log%] >> %logFile%
echo Access gived [%datetime-log%] >> %logFile%
echo Started update... [%datetime-log%] >> %logFile%
echo Updated [%datetime-log%] >> %logFile%


echo Accesing to web...
timeout /t 1 /nobreak >nul
del "main.bat"
"%CD%\Assets\wget.exe" -q --show-progress --connect-timeout=15 --tries=3 -P "%CD%" "https://raw.githubusercontent.com/OptiStudioXD/OptiTool/main/main.bat"
timeout /t 2 /nobreak >nul
echo Updated.
pause
exit