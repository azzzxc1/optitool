@echo off

color 0A
set INFO_TIT=OptiTool Info

:: Coloca el titulo
title %INFO_TIT%

:: Menu inicial
:Menu
:Menu
cls
echo ================================
echo           Hola!
echo ================================
echo 1 - Informacion sobre OptiTool!
echo 2 - Ejecutar OptiTool
echo 3 - Creditos
echo 4 - Salir
echo.

echo Esta version sera la ultima realizada en OptiTool
echo Gracias por todo.
echo -Att. Fernando (OptiStudio)
echo.

set /p choice="Selecciona una opcion (1-3): "

if "%choice%"=="1" goto Info
if "%choice%"=="2" goto Exec
if "%choice%"=="3" goto Creds
if "%choice%"=="4" goto exit

echo Opcion no valida. Por favor, elige una opcion del menu.
pause>nul
goto :Menu

:Exec
:Exec
cls
echo Ejecutando...
start "" "%~dp0Launcher.bat"
timeout /t 5 /nobreak >nul
goto exit

:Info
:Info
cls
echo ================================
echo           Informacion
echo ================================
echo.
echo OptiTool es un script de batch sencillo para aplicar optimizaciones a tu tostadora gamer de temu
echo.
echo Si deseas publicitar esta herramienta, no uses ningun acortador de enlaces para generar dinero 
echo y recuerda darme creditos (OptiStudio)
echo.
echo Puedes aplicar MAS optimizaciones utilizando los demas archivos que se encuentran en las carpetas
echo Appearance, Graphics, RAM y Resources. Son muy simple de aplicar. Abre el archivo .reg o .bat y listo!
echo Pero recuerda no usar la carpeta de scassets, ahi se encuentran archivos importantes!
echo.
echo Te preguntaras, como veo mi build y la version de mi Revision?
echo Es facil... ingresa a la consola (Assets\console.bat), despues, en la insercion de opciones coloca "version" y ejecutalo.
echo Ahi te mostrara toda la informacion de OptiTool (no la de sysinfo, creds, etc.)
echo.
echo En la carpeta raiz del programa (scassets o carpetas de optimizacion), no borres ningun recurso, ya que se necesita para aplicar 
echo las optimizaciones sin problemas.
echo.
echo NOTA: Este "programa" ES EXPERIMENTAL Y PUEDE PRESENTAR ERRORES.
echo       No se recomienda usar Windows modificados con este programa, ya que vienen con optimizaciones por defecto
echo       Si este programa dana tu Windows, NO me hago responsable; claramente te adverti.
echo.
echo Ubicacion de las optimizaciones:%~dp0\Assets
echo.
echo ================================
echo      = By OptiStudio =
echo ================================
echo.
timeout /t 10 /nobreak
pause
goto menu

:Creds
:Creds
cls
echo ================================
echo Creditos basicos:
echo.
echo Creador: OptiStudio
echo Version: 4.2 "The End."
echo Gmail: optistudio@hotmail.com
echo.
echo ================================
timeout /t 6 /nobreak
goto menu

:Exit
:Exit
cls
echo Saliendo del script...
timeout /t 2 > nul
echo Gracias por descargar!
pause
exit