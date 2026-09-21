@echo off
title overlay
color 0A

rem Inicializar archivo de registro
if not exist error_log.txt (
    echo Registro de Errores creado el %date% a las %time% > error_log.txt
)

:menu
cls
echo ================================
echo     .         .           .
echo ================================
echo 1. Soluciones
echo 2. Creditos
echo 3. Ayuda
echo 4. Ver Registro de Errores
echo 5. Salir
echo ================================
set /p option=Seleccione una opcion [1-5]: 

rem Validar la entrada del usuario
if "%option%"=="" goto menu
if "%option%"=="1" goto solutions
if "%option%"=="2" goto creds
if "%option%"=="3" goto help
if "%option%"=="4" goto log
if "%option%"=="5" exit

rem Manejar opción no válida
call :log_error "Opcion no valida: %option%"
echo Opcion no valida, intente de nuevo.
pause
goto menu

:solutions
cls
echo ================================
echo         Soluciones
echo ================================
echo.
echo Error: No inicia (0x1)
echo Solucion: Ejecute el script como administrador.
call :log_error "Error: No inicia (0x1) - Solucion: Ejecutar como administrador."
echo.
echo Error: El script no abre (0x2)
echo Solucion: Reinstale el script.
call :log_error "Error: El script no abre (0x2) - Solucion: Reinstalar el script."
echo.
echo Si conoces más problemas, contacta a "optiverse.studio@gmail.com"
echo.
pause
goto menu

:creds
cls
echo ================================
echo Creditos:
echo Creador: OptiStudio
echo Version: 5.0 "Winter Land"
echo Gmail: optiverse.studio@gmail.com
echo ================================
timeout /t 15 /nobreak >nul
goto menu

:help
cls
echo ================================
echo             Ayuda
echo ================================
echo Este script ofrece soluciones a errores comunes.
echo Seleccione una opción del menú principal para continuar.
echo.
echo Para cualquier duda, contacte a "optiverse.studio@gmail.com"
echo ================================
pause
goto menu

:log
cls
echo ================================
echo     Registro de Errores
echo ================================
if exist error_log.txt (
    type error_log.txt
) else (
    echo No se encontraron registros de errores.
)
echo ================================
pause
goto menu

:log_error
echo %date% %time% - %1 >> error_log.txt
goto :eof

