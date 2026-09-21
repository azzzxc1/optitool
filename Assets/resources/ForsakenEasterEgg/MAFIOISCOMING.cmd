@echo off
title MAFIOSO IS COMING


:Main
start "" "%~dp0files\DEBITODISONNO.mp3"
taskkill /f /im explorer.exe

:Bucle
echo MAFIOSO IS COMING! ! ! 
timeout /t 1 /nobreak>nul
goto :Bucle