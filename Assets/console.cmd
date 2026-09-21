@echo off

:: Establece el estilo PowerShell
color 1F

:: Establece el titulo
title OptiTool CMD

:: Establecer rutas
cd /d "%~dp0"
set C_DIR=%CD%

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
set "logFile=%~dp0scassets\logs\cmdacces-%datetime_log%.log"

:: Registrar el log de éxito
echo User trying to access console [%datetime_log%] >> "%logFile%"
echo Success: Permision gived >> "%logFile%"
echo All files loaded [%datetime_log%] >> "%logFile%"
echo Console loaded successfully [%datetime_log%] >> "%logFile%"


:MENU
cls
echo OptiStudio/OptiTool [Build 4.11100100.5000]
echo Copyright (c) 2025 OptiStudioXD
echo.
set /p COMMAND="$dir\%C_DIR%>

if "%COMMAND%"=="" goto :MENU
if "%COMMAND%"=="version" call :version
if "%COMMAND%"=="update" call :update
if "%COMMAND%"=="openFile--readme.txt" call :info
if "%COMMAND%"=="openFile--credits" call :allcreds
if "%COMMAND%"=="delete--dir" goto :deldir
goto :MENU

:update
echo.
echo Loading...
timeout /t 1 /nobreak>nul
echo File founded at [%datetime_log%]
timeout /t 1 /nobreak>nul
echo Loading script... [%datetime_log%]
timeout /t 2 /nobreak>nul
echo Starting... [%datetime_log%]
timeout /t 1 /nobreak>nul
echo 3...
timeout /t 1 /nobreak>nul
echo 2...
timeout /t 1 /nobreak>nul
echo 1.

start "" "%~dp0update.bat"

timeout /t 2 /nobreak >nul
goto MENU

:deldir
no

:version
echo.
echo ## Downloaded version: 4.1
echo.
echo ## OptiCore Info:
echo ## OptiBuild: nan
echo ## OptiCore Version: nan
echo ## OptiKernel Version: nan
echo.
echo ## Build Info: 
echo ## Build 4.11100100.5000
echo ## Version: 4.1 Rev A
echo ## Version Codename: Sandstorm
echo ## Kernel: nan
echo.
echo ## Linux Info:
echo ## Linux Compatibility: N/A
echo ## Linux Build: N/A
pause>nul
goto MENU

:info
echo.
echo If you downloaded this program outside of the official GitHub, check your computer because it may be a virus.
echo.
echo -By OptiStudio
echo.
echo - - - - - - - - - - - - - - - - - - - - - - - -
echo.
echo MIT License
echo.
echo Copyright (c) 2025 OptiStudioXD
echo.
echo Permission is hereby granted, free of charge, to any person obtaining a copy
echo of this software and associated documentation files (the "Software"), to deal
echo in the Software without restriction, including without limitation the rights
echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo copies of the Software, and to permit persons to whom the Software is
echo furnished to do so, subject to the following conditions:
echo.
echo The above copyright notice and this permission notice shall be included in all
echo copies or substantial portions of the Software.
echo.
echo THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo SOFTWARE.
echo.
echo - - - - - - - - - - - - - - - - - - - - - - - -
echo.
echo Project: OptiTool - OptiStudio - Creator of OptiTool
echo                     Luisreach17 - Owner of OptiStudio
echo O                   Chris Titus - Code in OptiTool (20%) (No official helper)
echo P                   OptiJuegos (Optimizar PC) - Original Idea
echo T
echo I          - OptiStudio
echo T
echo O
echo O
echo L
echo.
pause>nul
goto MENU

:allcreds
