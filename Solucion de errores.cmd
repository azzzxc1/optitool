@echo off
color 0A
set BUGFIX_VER=OptiTool Bug Fix 8.0


:: Coloca el titulo
title Fix Tool

:: Menu principal
:MENU
:MENU
:: Muestra el menu principal
cls
echo ================================
echo            Bug Fix
echo ================================
echo 1 - Soluciones
echo 2 - Creditos
echo 3 - Ayuda
echo 4 - Niveles de errores
echo 5 - Notas
echo 6 - Salir
echo ================================
echo.
echo Esta version sera la ultima realizada en OptiTool
echo Gracias por todo.
echo -Att. Fernando (OptiStudio)
echo.

:: Insercion de opciones
set /p option=Opcion: 



:: Codigo para aceptar los comandos
if "%option%"=="1" goto solutions
if "%option%"=="2" goto creds
if "%option%"=="3" goto help
if "%option%"=="4" goto :Scale
if "%option%"=="5" goto notes
if "%option%"=="6" exit

echo Opcion no valida. Intente de nuevo.
pause
goto menu

:: Escala de niveles de errores
:Scale
:Scale
cls
echo ================================
echo   Escala de nivel de errores
echo ================================
echo.
echo (0x*) Errores de nivel 0 (Bajos)
echo (1x*) Errores de nivel 1 (Bajos-Medios)
echo (2x*) Errores de nivel 2 (Medios)
echo (3x*) Errores de nivel 3 (Medios-Altos)
echo (4x*) Errores de nivel 4 (Altos)
echo (5x*) Errores de nivel 5 (Altos-Criticos)
echo (6x*) Errores de nivel 6 (Criticos)
echo (7x*) Errores de nivel 7 (Criticos-Irreparables)
echo (8x*) Errores de nivel 8 (Irreparables + Criticos)
echo.
echo Errores extra:
echo (0k*) Errores de nivel Anonymous (Se desconoce su causa)
echo (0s*) Errores de nivel Software (Tu version de Windows no acepta los comandos)
echo (0unr*) Errores inrreparables
echo.

pause
goto menu


:: Soluciones 
:solutions
cls
echo ================================
echo         Soluciones
echo ================================
echo 1. Error: No inicia (0x1) - Solucion: Ejecute el script como administrador.
echo 2. Error: No aplica las optis (4x1) - Solucion: Descargue una version anterior y reportelo mediante correo a "optistudio@hotmail.com"
echo 3. Error: Errores con report.txt o test_results.txt (2k1) Solucion: no hay ;b (creo)
echo 4. Error: Las optimizaciones anadidas en la 4.0 no funcionan (4x2) Solucion: Descargue una version anterior y espere la Revision
echo 5. Error: Tengo Windows 8.1 o inferior y no aplica las Optis (7unr1) Solucion: Si es posible, instale una version nueva de Windows.
echo.

echo Si tienes errores no conocidos envialos a: optistudio@hotmail.com
echo.

pause
goto menu

:notes
cls
echo Nota 1: Si deseas descargar la mejor version antigua actualmente es la 2.7 "semaG itpO" y
echo la 2.99.3 "El Fin se Acerca" o si quieres algo mas nuevo, puedes optar por la 3.9 o la 4.0
echo.
echo Nota 2: Por que cada vez las versiones se hacen mas pesadas, por que si.
echo.
pause
goto menu

:creds
cls
echo ================================
echo.
echo Creditos basicos:
echo Creador: OptiStudioXD
echo Version del script: 4.2 "The End."
echo.
echo ================================
pause
goto menu

:help
cls
echo ================================
echo             Ayuda
echo ================================
echo.
echo Este script ofrece soluciones a errores comunes.
echo Para cualquier duda, contacte a "optistudio@hotmail.com"
echo.
echo ================================
pause
goto menu
