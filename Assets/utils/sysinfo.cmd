@echo off
setlocal EnableDelayedExpansion
title OptiTool - System Information
color 0A

set "LOGDIR=%~dp0..\logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%" >nul 2>&1

goto Menu

:Menu
call :ShowHeader "System Information"
echo 1 - Quick summary
echo 2 - Full system information (systeminfo)
echo 3 - Hardware details (CPU/GPU/RAM/Motherboard/BIOS)
echo 4 - Disk and storage info
echo 5 - Network info
echo 6 - Installed drivers
echo 7 - Save full report to file
echo 8 - Help
echo 9 - Exit
echo.
set /p SI_OP="Option: "
if "%SI_OP%"=="1" (call :ShowHeader "Quick summary" & call :QuickSummary & call :Pause2 & goto Menu)
if "%SI_OP%"=="2" (call :ShowHeader "Full system information" & call :FullSystemInfo & call :Pause2 & goto Menu)
if "%SI_OP%"=="3" (call :ShowHeader "Hardware details" & call :HardwareDetails & call :Pause2 & goto Menu)
if "%SI_OP%"=="4" (call :ShowHeader "Disk and storage info" & call :DiskInfo & call :Pause2 & goto Menu)
if "%SI_OP%"=="5" (call :ShowHeader "Network info" & call :NetworkInfo & call :Pause2 & goto Menu)
if "%SI_OP%"=="6" (call :ShowHeader "Installed drivers" & call :DriversInfo & call :Pause2 & goto Menu)
if "%SI_OP%"=="7" goto SaveInfo
if "%SI_OP%"=="8" goto Help
if "%SI_OP%"=="9" goto End
goto Menu

:SaveInfo
call :ShowHeader "Save full report"
set "SI_RAW="
for /f "tokens=2 delims==" %%I in ('wmic OS Get localdatetime /value 2^>nul ^| find "="') do set "SI_RAW=%%I"
if defined SI_RAW (
    set "SI_STAMP=%SI_RAW:~0,8%_%SI_RAW:~8,6%"
) else (
    set "SI_STAMP=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    set "SI_STAMP=%SI_STAMP: =0%"
)
set "SI_FILE=%LOGDIR%\sysinfo-%SI_STAMP%.txt"
echo Building report, this can take a moment...
(
    echo OptiTool System Information Report
    echo Generated: %date% %time%
    echo.
    echo ===== QUICK SUMMARY =====
) > "%SI_FILE%"
call :QuickSummary >> "%SI_FILE%"
(
    echo.
    echo ===== FULL SYSTEM INFORMATION =====
) >> "%SI_FILE%"
call :FullSystemInfo >> "%SI_FILE%"
(
    echo.
    echo ===== HARDWARE DETAILS =====
) >> "%SI_FILE%"
call :HardwareDetails >> "%SI_FILE%"
(
    echo.
    echo ===== DISK AND STORAGE =====
) >> "%SI_FILE%"
call :DiskInfo >> "%SI_FILE%"
(
    echo.
    echo ===== NETWORK =====
) >> "%SI_FILE%"
call :NetworkInfo >> "%SI_FILE%"
(
    echo.
    echo ===== INSTALLED DRIVERS =====
) >> "%SI_FILE%"
call :DriversInfo >> "%SI_FILE%"
echo.
echo Report saved to:
echo   %SI_FILE%
call :Pause2
goto Menu

:QuickSummary
echo Operating system:
powershell -NoProfile -Command "(Get-CimInstance Win32_OperatingSystem).Caption + ' (' + (Get-CimInstance Win32_OperatingSystem).OSArchitecture + ')'"
echo.
echo CPU:
powershell -NoProfile -Command "(Get-CimInstance Win32_Processor).Name"
echo.
echo GPU:
powershell -NoProfile -Command "(Get-CimInstance Win32_VideoController).Name"
echo.
echo Memory (RAM):
powershell -NoProfile -Command "$os=Get-CimInstance Win32_OperatingSystem; '{0:N1} GB total / {1:N1} GB free' -f ($os.TotalVisibleMemorySize/1MB), ($os.FreePhysicalMemory/1MB)"
echo.
echo System drive free space:
powershell -NoProfile -Command "$d=Get-PSDrive -Name ($env:SystemDrive.TrimEnd(':')); '{0:N1} GB free / {1:N1} GB total' -f ($d.Free/1GB), (($d.Free+$d.Used)/1GB)"
echo.
echo Uptime:
powershell -NoProfile -Command "$u=(Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime; '{0}d {1}h {2}m' -f $u.Days, $u.Hours, $u.Minutes"
goto :eof

:FullSystemInfo
systeminfo
goto :eof

:HardwareDetails
echo -- CPU --
powershell -NoProfile -Command "Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed | Format-List"
echo -- GPU --
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | Select-Object Name, DriverVersion, @{N='VRAM(MB)';E={[math]::round($_.AdapterRAM/1MB)}} | Format-List"
echo -- RAM modules --
powershell -NoProfile -Command "Get-CimInstance Win32_PhysicalMemory | Select-Object @{N='Capacity(GB)';E={[math]::round($_.Capacity/1GB,2)}}, Speed, Manufacturer, PartNumber | Format-Table -AutoSize"
echo -- Motherboard --
powershell -NoProfile -Command "Get-CimInstance Win32_BaseBoard | Select-Object Manufacturer, Product | Format-List"
echo -- BIOS --
powershell -NoProfile -Command "Get-CimInstance Win32_BIOS | Select-Object Manufacturer, SMBIOSBIOSVersion, ReleaseDate | Format-List"
goto :eof

:DiskInfo
echo -- Volumes --
fsutil fsinfo drives
echo.
echo -- Disk usage --
powershell -NoProfile -Command "Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{N='Used(GB)';E={[math]::round($_.Used/1GB,1)}}, @{N='Free(GB)';E={[math]::round($_.Free/1GB,1)}} | Format-Table -AutoSize"
echo.
echo -- Physical disk health --
powershell -NoProfile -Command "try { Get-PhysicalDisk | Select-Object DeviceId, FriendlyName, MediaType, HealthStatus, OperationalStatus | Format-Table -AutoSize } catch { Write-Host 'Physical disk health data is not available on this system.' }"
goto :eof

:NetworkInfo
echo -- Active adapters --
powershell -NoProfile -Command "Get-NetAdapter | Where-Object Status -eq 'Up' | Select-Object Name, InterfaceDescription, LinkSpeed | Format-Table -AutoSize"
echo -- Full configuration --
ipconfig /all
goto :eof

:DriversInfo
driverquery /fo table
goto :eof

:Help
call :ShowHeader "Help"
echo This tool shows basic and detailed information about your PC:
echo operating system, CPU, GPU, memory, disks, network adapters and
echo installed drivers.
echo.
echo Quick summary  - fast overview, good for a first look.
echo Full/Hardware/Disk/Network/Drivers - detailed sections on screen.
echo Save full report - writes everything above into one timestamped
echo   .txt file inside the logs folder, so you can share it or keep
echo   it for comparison later.
call :Pause2
goto Menu

:End
exit

:Pause2
echo.
pause
goto :eof

:ShowHeader
cls
echo ==================================================
call :CenterLine "%~1"
echo ==================================================
echo.
goto :eof

:CenterLine
setlocal EnableDelayedExpansion
set "CL_TEXT=%~1"
set "CL_WIDTH=50"
set "CL_LEN=0"
:CenterLineLoop
if not "!CL_TEXT:~%CL_LEN%,1!"=="" (
    set /a CL_LEN+=1
    goto CenterLineLoop
)
set /a CL_PAD=(CL_WIDTH-CL_LEN)/2
if %CL_PAD% LSS 0 set "CL_PAD=0"
set "CL_SPACES="
for /l %%i in (1,1,%CL_PAD%) do set "CL_SPACES=!CL_SPACES! "
echo !CL_SPACES!!CL_TEXT!
endlocal
goto :eof