@echo off
cls
title wu10man removeservice

:: Deshabilitar la confirmación para eliminar archivos
setlocal enabledelayedexpansion

:: Ruta del directorio actual
set "current_dir=%~dp0"

:: Eliminar archivos
del /f /s /q "%current_dir%\*.*"

:: Eliminar subdirectorios
for /d %%i in ("%current_dir%\*") do rd /s /q "%%i"

:: Esperar un momento para asegurarse de que todo se haya eliminado
timeout /t 2 /nobreak >nul

:: Eliminar el propio script (el script que se está ejecutando)
del "%~f0"

exit
