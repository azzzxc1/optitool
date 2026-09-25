@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"

if not exist "info" mkdir "info" >nul 2>&1
if not exist "logs" mkdir "logs" >nul 2>&1

call :EnsureConfig
call :LoadConfig
call :InitLog
timeout /t 1 /nobreak >nul

color %CFG_COLOR%
title OptiTool

goto MainMenu

:MainMenu
call :ShowHeader "OptiTool"
echo 1 - Recommended optimization
echo 2 - Restore points
echo 3 - Optimization menu
echo 4 - Additional options
echo 5 - Tools
echo 6 - Advanced
echo 7 - Security
echo 8 - IRMs
echo 9 - Exit
echo.
set /p MM_OP="Option: "
if "%MM_OP%"=="1" goto RecommendedOpt
if "%MM_OP%"=="2" goto RestorePointsMenu
if "%MM_OP%"=="3" goto OptimizationMenu
if "%MM_OP%"=="4" goto AdditionalMenu
if "%MM_OP%"=="5" goto ToolsMenu
if "%MM_OP%"=="6" goto AdvancedMenu
if "%MM_OP%"=="7" goto SecurityMenu
if "%MM_OP%"=="8" goto IrmMenu
if "%MM_OP%"=="9" goto ExitScript
goto MainMenu

:RecommendedOpt
call :ShowHeader "Recommended optimization"
set /p RO_RP="Create a restore point before starting? (Y/N): "
if /I "%RO_RP%"=="Y" call :CreateRestorePoint
set /p RO_PROG="Install recommended programs (7-Zip, VLC, etc.)? (Y/N): "
if /I "%RO_PROG%"=="Y" call :InstallRecommendedPrograms
call :Log "RecommendedOpt" "start"
call :ApplyGeneralTweaks
call :ApplyVisualTweaks
call :SetGamePriority
call :DisableWifiSense
call :DisableUpdateTasks
call :DisableTelemetryTasks
call :SetServicesManual
call :DisableUnneededServices
call :ApplyBcdEdit
call :ActivatePowerPlan
call :Log "RecommendedOpt" "finished"
echo.
echo - Recommended optimization finished. Restart your PC to apply all changes.
call :Pause2
goto MainMenu

:RestorePointsMenu
call :ShowHeader "Restore points"
echo 1 - Create a new restore point
echo 2 - Reduce restore point storage size
echo 3 - Back
echo.
set /p RP_OP="Option: "
if "%RP_OP%"=="1" (
    call :CreateRestorePoint
    goto RestorePointsMenu
)
if "%RP_OP%"=="2" (
    call :ResizeRestoreStorage
    goto RestorePointsMenu
)
if "%RP_OP%"=="3" goto MainMenu
goto RestorePointsMenu

:OptimizationMenu
call :ShowHeader "Optimization menu"
echo  1 - Optimize PC                     16 - Delete failed updates
echo  2 - Optimize RAM                    17 - Disk cleanup
echo  3 - Delete temporary files          18 - Disable MS account sync
echo  4 - Optimize network                19 - Set services to manual
echo  5 - Clean cache                     20 - Disable fullscreen optimizations
echo  6 - Defragment HDD                  21 - Disable telemetry
echo  7 - Check disk health               22 - Disable unnecessary services
echo  8 - Manage startup programs         23 - Disable background apps
echo  9 - Update drivers                  24 - Optimize visual effects
echo 10 - Repair system files             25 - Set high priority for games
echo 11 - Disable notifications           26 - Reduce svchost processes
echo 12 - Restart Explorer                27 - Disable Game DVR
echo 13 - Delete memory dumps             28 - Disable window transparency
echo 14 - Disable file indexing           29 - Disable hardware acceleration
echo 15 - Reduce restore point storage    30 - Back
echo.
set /p OM_OP="Option: "
if "%OM_OP%"=="1"  (call :ApplyGeneralTweaks & call :ApplyBcdEdit & call :ActivatePowerPlan & call :Log "Optimization" "FullPCOptimize" & call :Pause2 & goto OptimizationMenu)
if "%OM_OP%"=="2"  (call :OptimizeRAM & goto OptimizationMenu)
if "%OM_OP%"=="3"  (call :DeleteTempFiles & goto OptimizationMenu)
if "%OM_OP%"=="4"  (call :OptimizeNetwork & goto OptimizationMenu)
if "%OM_OP%"=="5"  (call :CleanCache & goto OptimizationMenu)
if "%OM_OP%"=="6"  (call :DefragDisk & goto OptimizationMenu)
if "%OM_OP%"=="7"  (call :CheckDisk & goto OptimizationMenu)
if "%OM_OP%"=="8"  (call :ManageStartup & goto OptimizationMenu)
if "%OM_OP%"=="9"  (call :UpdateDrivers & goto OptimizationMenu)
if "%OM_OP%"=="10" (call :RepairSystemFiles & goto OptimizationMenu)
if "%OM_OP%"=="11" (call :DisableNotifications & goto OptimizationMenu)
if "%OM_OP%"=="12" (call :RestartExplorer & goto OptimizationMenu)
if "%OM_OP%"=="13" (call :DeleteMemoryDumps & goto OptimizationMenu)
if "%OM_OP%"=="14" (call :DisableFileIndexing & goto OptimizationMenu)
if "%OM_OP%"=="15" (call :ResizeRestoreStorage & goto OptimizationMenu)
if "%OM_OP%"=="16" (call :DeleteFailedUpdates & goto OptimizationMenu)
if "%OM_OP%"=="17" (call :RunDiskCleanup & goto OptimizationMenu)
if "%OM_OP%"=="18" (call :DisableMSSync & goto OptimizationMenu)
if "%OM_OP%"=="19" (call :SetServicesManual & call :Log "Optimization" "SetServicesManual" & call :Pause2 & goto OptimizationMenu)
if "%OM_OP%"=="20" (call :DisableFullScreenOpti & goto OptimizationMenu)
if "%OM_OP%"=="21" (call :DisableTelemetryTweaks & call :DisableTelemetryTasks & call :Log "Optimization" "DisableTelemetry" & call :Pause2 & goto OptimizationMenu)
if "%OM_OP%"=="22" (call :DisableUnneededServices & call :Log "Optimization" "DisableUnneededServices" & call :Pause2 & goto OptimizationMenu)
if "%OM_OP%"=="23" (call :DisableBackgroundApps & goto OptimizationMenu)
if "%OM_OP%"=="24" (call :ApplyVisualTweaks & call :Log "Optimization" "ApplyVisualTweaks" & call :Pause2 & goto OptimizationMenu)
if "%OM_OP%"=="25" (call :SetGamePriority & call :Log "Optimization" "SetGamePriority" & call :Pause2 & goto OptimizationMenu)
if "%OM_OP%"=="26" (call :ReduceSvchost & goto OptimizationMenu)
if "%OM_OP%"=="27" (call :DisableGameDVR & goto OptimizationMenu)
if "%OM_OP%"=="28" (call :DisableWindowTransparency & goto OptimizationMenu)
if "%OM_OP%"=="29" (call :DisableHardwareAcceleration & goto OptimizationMenu)
if "%OM_OP%"=="30" goto MainMenu
goto OptimizationMenu

:AdvancedMenu
call :ShowHeader "Advanced"
echo 1 - Disable CPU vulnerability mitigations (Spectre/Meltdown)
echo 2 - Re-enable CPU vulnerability mitigations
echo 3 - Remove pre-installed apps (non-Store)
echo 4 - Clean up WinSxS (DISM component cleanup)
echo 5 - Back
echo.
set /p AD_OP="Option: "
if "%AD_OP%"=="1" (call :DisableCpuMitigations & goto AdvancedMenu)
if "%AD_OP%"=="2" (call :EnableCpuMitigations & goto AdvancedMenu)
if "%AD_OP%"=="3" (call :RemoveBloatApps & goto AdvancedMenu)
if "%AD_OP%"=="4" (call :CleanupWinSxS & goto AdvancedMenu)
if "%AD_OP%"=="5" goto MainMenu
goto AdvancedMenu

:ToolsMenu
call :ShowHeader "Tools"
echo 1  - Auto Keyboard 
echo 2  - Auto Clicker
echo 3  - Uninstall Tool
echo 4  - Driver Booster
echo 5  - ADB AppControl
echo 6  - WinRAR
echo 7  - SuperF4
echo 8  - HWiNFO
echo 9  - CPU-Z
echo 10 - GPU-Z
echo 11 - Everything (voidtools)
echo 12 - Wireshark
echo 13 - CrystalDiskInfo
echo 14 - Back
echo.
set /p TM_OP="Option: "
if "%TM_OP%"=="1"  (call :LaunchTool "AutoKeyboard" "thirdparty\auto-keyboard\AutoKeyboard.exe" & goto ToolsMenu)
if "%TM_OP%"=="2"  (call :LaunchTool "AutoClicker" "thirdparty\auto-clicker\AutoClicker.exe" & goto ToolsMenu)
if "%TM_OP%"=="3"  (call :LaunchTool "UninstallTool" "thirdparty\uninstall-tool\geek.exe" & goto ToolsMenu)
if "%TM_OP%"=="4"  (call :LaunchTool "DriverBooster" "thirdparty\driver-booster\DriverBoosterPortable.exe" & goto ToolsMenu)
if "%TM_OP%"=="5"  (call :LaunchTool "ADBAppControl" "thirdparty\adb-appcontrol\ADBAppControl.exe" & goto ToolsMenu)
if "%TM_OP%"=="6"  (call :LaunchTool "WinRAR" "thirdparty\winRAR\WinRAR.exe" & goto ToolsMenu)
if "%TM_OP%"=="7"  (call :LaunchTool "SuperF4" "thirdparty\superF4\SuperF4.exe" & goto ToolsMenu)
if "%TM_OP%"=="8"  (call :LaunchTool "HWiNFO" "thirdparty\hwinfo\HWiNFO64.exe" & goto ToolsMenu)
if "%TM_OP%"=="9"  (call :LaunchTool "CPUZ" "thirdparty\cpuZ\cpuz_x64.exe" & goto ToolsMenu)
if "%TM_OP%"=="10"  (call :LaunchTool "GPUZ" "thirdparty\gpuZ\gpu.exe" & goto ToolsMenu)
if "%TM_OP%"=="11"  (call :LaunchTool "Everything" "thirdparty\everything\Everything.exe" & goto ToolsMenu)
if "%TM_OP%"=="12"  (call :LaunchTool "Wireshark" "thirdparty\wireshark\WiresharkPortable64.exe" & goto ToolsMenu)
if "%TM_OP%"=="13"  (call :LaunchTool "CrystalDiskInfo" "thirdparty/cdi/DiskInfo64.exe" & goto ToolsMenu)
if "%TM_OP%"=="14" goto MainMenu
goto ToolsMenu

:AdditionalMenu
call :ShowHeader "Additional Menu"
echo 1 - System Info
echo 2 - Clear logs
echo 3 - View current log
echo 4 - Back
echo.
set /p AM_OP="Option: "
if "%AM_OP%"=="1" (call :LaunchTool "Sysinfo" "utils\sysinfo.cmd" & goto AdditionalMenu)
if "%AM_OP%"=="2" (call :ClearOptiToolLogs & goto AdditionalMenu)
if "%AM_OP%"=="3" (call :ViewCurrentLog & goto AdditionalMenu)
if "%AM_OP%"=="4" goto MainMenu
goto AdditionalMenu

:SecurityMenu
call :ShowHeader "Security" "Windows Defender options"
echo 1 - Disable Windows Defender
echo 2 - Enable Windows Defender
echo 3 - Check Windows Defender status
echo 4 - Back
echo.
set /p SM_OP="Option: "
if "%SM_OP%"=="1" (call :DisableDefender & goto SecurityMenu)
if "%SM_OP%"=="2" (call :EnableDefender & goto SecurityMenu)
if "%SM_OP%"=="3" (call :CheckDefenderStatus & goto SecurityMenu)
if "%SM_OP%"=="4" goto MainMenu
goto SecurityMenu

:IrmMenu
call :ShowHeader "Remote scripts (IRM)"
echo 1  - WinUtil (Chris Titus Tech)
echo 2  - Microsoft Activation Scripts (MAS)
echo 3  - Win11Debloat (Raphire)
echo 4  - Winhance
echo 5  - Back
echo.
set /p IRM_OP="Option: "
if "%IRM_OP%"=="1" (call :LaunchIRM "WinUtil" "https://christitus.com/win" & goto IrmMenu)
if "%IRM_OP%"=="2" (call :LaunchIRM "MAS" "https://get.activated.win" & goto IrmMenu)
if "%IRM_OP%"=="3" (call :LaunchIRM "Win11Debloat" "https://debloat.raphi.re/" & goto IrmMenu)
if "%IRM_OP%"=="4" (call :LaunchIRM "Winhance" "https://get.winhance.net" & goto IrmMenu)
if "%IRM_OP%"=="5" goto MainMenu
goto IrmMenu

:ExitScript
call :Log "Session" "exit"
endlocal
exit /b

:EnsureConfig
if exist "info\config.txt" goto :eof
(
    echo color=0A
    echo disable_logs=0
    echo confirm_before_actions=1
    echo default_restore_point=1
) > "info\config.txt"
goto :eof

:LoadConfig
set "CFG_COLOR=0A"
set "CFG_DISABLE_LOGS=0"
set "CFG_CONFIRM_BEFORE_ACTIONS=1"
set "CFG_DEFAULT_RESTORE_POINT=1"
for /f "usebackq tokens=1,2 delims==" %%A in ("info\config.txt") do (
    if /I "%%A"=="color" set "CFG_COLOR=%%B"
    if /I "%%A"=="disable_logs" set "CFG_DISABLE_LOGS=%%B"
    if /I "%%A"=="confirm_before_actions" set "CFG_CONFIRM_BEFORE_ACTIONS=%%B"
    if /I "%%A"=="default_restore_point" set "CFG_DEFAULT_RESTORE_POINT=%%B"
)
goto :eof

:InitLog
set "LT_RAW="
for /f "tokens=2 delims==" %%I in ('wmic OS Get localdatetime /value 2^>nul ^| find "="') do set "LT_RAW=%%I"
if defined LT_RAW (
    set "LOGSTAMP=%LT_RAW:~0,8%_%LT_RAW:~8,6%"
) else (
    set "LOGSTAMP=%date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
    set "LOGSTAMP=%LOGSTAMP: =0%"
)
if not exist "logs" mkdir "logs" >nul 2>&1
set "LOGFILE=%~dp0logs\session-%LOGSTAMP%.log"
if "%CFG_DISABLE_LOGS%"=="1" (
    set "LOGSTATUS=OFF"
) else (
    set "LOGSTATUS=ON"
    echo OptiTool session log > "%LOGFILE%"
    echo Started: %date% %time% >> "%LOGFILE%"
    echo. >> "%LOGFILE%"
    call :Log "Session" "start"
)
goto :eof

:Log
if "%CFG_DISABLE_LOGS%"=="1" goto :eof
if not exist "logs" mkdir "logs" >nul 2>&1
echo [%date% %time%] action=%~1 detail=%~2 >> "%LOGFILE%"
goto :eof

:Pause2
echo.
pause
goto :eof

:ShowHeader
cls
echo ==================================================
call :CenterLine "%~1"
if not "%~2"=="" call :CenterLine "%~2"
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

:CreateRestorePoint
echo Creating restore point...
powershell -NoProfile -Command "Enable-ComputerRestore -Drive '%SystemDrive%'; try { Checkpoint-Computer -Description 'OptiTool' -ErrorAction Stop } catch { Write-Host $_.Exception.Message }"
call :Log "RestorePoint" "created"
goto :eof

:ResizeRestoreStorage
set "RP_SIZE=3GB"
echo Setting restore point storage size to %RP_SIZE%...
vssadmin Resize ShadowStorage /For=%SystemDrive% /On=%SystemDrive% /MaxSize=%RP_SIZE%
call :Log "RestorePoint" "resized_storage_%RP_SIZE%"
call :Pause2
goto :eof

:ApplyGeneralTweaks
echo Applying registry tweaks...
if exist "services\OptimizeServices.reg" regedit /S "services\OptimizeServices.reg"
if exist "general\FastMenu.reg" regedit /S "general\FastMenu.reg"
if exist "general\GeneralTweaks.reg" regedit /S "general\GeneralTweaks.reg"
if exist "gpu\OpINTEL.reg" regedit /S "gpu\OpINTEL.reg"
if exist "gpu\OpNVIDIA.reg" regedit /S "gpu\OpNVIDIA.reg"
if exist "gpu\DisableDVBR.reg" regedit /S "gpu\DisableDVBR.reg"
if exist "memory\RAM.reg" regedit /S "memory\RAM.reg"
if exist "telemetry\DisableTelemetry.reg" regedit /S "telemetry\DisableTelemetry.reg"
call :Log "Tweaks" "ApplyGeneralTweaks"
echo Done.
goto :eof

:ApplyVisualTweaks
echo Optimizing visual effects...
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 200 /f >nul
reg add "HKCU\Control Panel\Desktop" /v MinAnimate /t REG_SZ /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v KeyboardDelay /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v VisualFXSetting /t REG_DWORD /d 3 /f >nul
reg add "HKCU\Control Panel\Desktop" /v EnableAeroPeek /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v AutoEndTasks /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
echo Done.
goto :eof

:SetGamePriority
echo Setting high priority for common games and tools...
for %%P in (csgo.exe cs2.exe FortniteClient-Win64-Shipping.exe gta_sa.exe GTA5.exe java.exe javaw.exe minecraft.exe Minecraft.Windows.exe obs32.exe obs64.exe) do (
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\%%P\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 6 /f >nul
)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\svchost.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 5 /f >nul
echo Done.
goto :eof

:DisableWifiSense
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /v AllowWiFiHotSpotReporting /t REG_DWORD /d 0 /f >nul
reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi" /v AllowAutoConnectToWiFiSenseHotspots /t REG_DWORD /d 0 /f >nul
call :Log "Tweaks" "DisableWifiSense"
goto :eof

:DisableUpdateTasks
for %%T in ("\Microsoft\Windows\InstallService\*" "\Microsoft\Windows\UpdateOrchestrator\*" "\Microsoft\Windows\UpdateAssistant\*" "\Microsoft\Windows\WaaSMedic\*" "\Microsoft\Windows\WindowsUpdate\*") do (
    schtasks /Change /TN %%T /Disable >nul 2>&1
)
call :Log "Tweaks" "DisableUpdateTasks"
goto :eof

:DisableTelemetryTasks
for %%T in ("Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" "Microsoft\Windows\Application Experience\ProgramDataUpdater" "Microsoft\Windows\Autochk\Proxy" "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" "Microsoft\Windows\Feedback\Siuf\DmClient" "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" "Microsoft\Windows\Windows Error Reporting\QueueReporting" "Microsoft\Windows\Application Experience\MareBackup" "Microsoft\Windows\Application Experience\StartupAppTask" "Microsoft\Windows\Application Experience\PcaPatchDbTask" "Microsoft\Windows\Maps\MapsUpdateTask") do (
    schtasks /Change /TN "%%T" /Disable >nul 2>&1
)
goto :eof

:DisableTelemetryTweaks
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v NumberOfSIUFInPeriod /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v DoNotShowFeedbackNotifications /t REG_DWORD /d 1 /f >nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v DisableTailoredExperiencesWithDiagnosticData /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul
goto :eof

:ApplyBcdEdit
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
powercfg -h off >nul 2>&1
call :Log "Tweaks" "ApplyBcdEdit"
goto :eof

:ActivatePowerPlan
if exist "power\OptiVortex.pow" (
    powercfg -import "power\OptiVortex.pow" a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
    powercfg /setactive a11a11c9-6d83-493e-a38d-d5fa3c620915 >nul 2>&1
    call :Log "Tweaks" "ActivatePowerPlan"
)
goto :eof

:SetServicesManual
echo Setting non-critical services to manual start...
for %%S in (AJRouter ALG AppIDSvc AppMgmt AppReadiness AppXSvc Appinfo AssignedAccessManagerSvc AxInstSV BDESVC BTAGService Browser CertPropSvc ClipSVC CscService DcpSvc DevQueryBroker DeviceAssociationService DeviceInstall DisplayEnhancementService DmEnrollmentSvc DsSvc DsmSvc EFS EapHost EntAppSvc FDResPub Fax FrameServer FrameServerMonitor GraphicsPerfSvc HvHost IKEEXT InstallService InventorySvc IpxlatCfgSvc KtmRm LicenseManager LxpSvc MSDTC MSiSCSI McpManagementService MicrosoftEdgeElevationService MixedRealityOpenXRSvc NaturalAuthentication NcaSvc NcbService NcdAutoSetup NetSetupSvc Netman NgcCtnrSvc NgcSvc NlaSvc PNRPAutoReg PNRPsvc PeerDistSvc PerfHost PhoneSvc PlugPlay PolicyAgent PrintNotify PushToInstall QWAVE RasAuto RasMan RetailDemo RmSvc RpcLocator SCPolicySvc SCardSvr SDRSVC SEMgrSvc SNMPTRAP SSDPSRV ScDeviceEnum SecurityHealthService Sense SensorDataService SensorService SensrSvc SessionEnv SharedAccess SharedRealitySvc SmsRouter SstpSvc StiSvc TabletInputService TapiSrv TieringEngineService TimeBroker TimeBrokerSvc TokenBroker TroubleshootingSvc TrustedInstaller UI0Detect UmRdpService VSS VacSvc W32Time WEPHOSTSVC WFDSConMgrSvc WMPNetworkSvc WManSvc WPDBusEnum WSService WaaSMedicSvc WalletService WarpJITSvc WbioSrvc WcsPlugInService WdNisSvc WdiServiceHost WdiSystemHost WebClient Wecsvc WerSvc WiaRpc WinHttpAutoProxySvc WinRM WpcMonSvc XblAuthManager XblGameSave XboxGipSvc XboxNetApiSvc autotimesvc bthserv camsvc cloudidsvc dcsvc defragsvc diagnosticshub.standardcollector.service diagsvc dmwappushservice dot3svc edgeupdate edgeupdatem embeddedmode fdPHost fhsvc hidserv icssvc lfsvc lltdsvc lmhosts msiserver netprofm p2pimsvc p2psvc perceptionsimulation pla seclogon smphost spectrum svsvc swprv upnphost vds vmicguestinterface vmicheartbeat vmickvpexchange vmicrdv vmicshutdown vmictimesync vmicvmsession vmicvss vmvss wbengine wcncsvc webthreatdefsvc wercplsupport wisvc wlidsvc wlpasvc wmiApSrv workfolderssvc wuauserv wudfsvc) do (
    sc config "%%S" start= demand >nul 2>&1
)
echo Done.
goto :eof

:DisableUnneededServices
echo Disabling non-essential services...
for %%S in (diagnosticshub.standardcollector.service DiagTrack DPS FontCache SystemUsageReportSvc_QUEENCREEK GpuEnergyDrv PcaSvc ShellHWDetection SgrmAgent SgrmBroker uhssvc WdiServiceHost WdiSystemHost WSearch diagsvc) do (
    sc config "%%S" start= disabled >nul 2>&1
)
echo Done.
goto :eof

:OptimizeRAM
echo Optimizing RAM...
if exist "services\OptimizeServices.reg" regedit /S "services\OptimizeServices.reg"
if exist "telemetry\DisableTelemetry.reg" regedit /S "telemetry\DisableTelemetry.reg"
if exist "gpu\OpINTEL.reg" regedit /S "gpu\OpINTEL.reg"
if exist "gpu\OpNVIDIA.reg" regedit /S "gpu\OpNVIDIA.reg"
if exist "gpu\DisableDVBR.reg" regedit /S "gpu\DisableDVBR.reg"
if exist "memory\RAM.reg" regedit /S "memory\RAM.reg"
powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression" >nul 2>&1
powershell -NoProfile -Command "Enable-MMAgent -MemoryCompression" >nul 2>&1
call :Log "Optimization" "OptimizeRAM"
echo Done.
call :Pause2
goto :eof

:DeleteTempFiles
echo Deleting temporary files...
del /S /F /Q "%temp%\*.*" >nul 2>&1
del /S /F /Q "%WINDIR%\Temp\*.*" >nul 2>&1
del /S /F /Q "%WINDIR%\Prefetch\*.*" >nul 2>&1
del /S /F /Q "%WINDIR%\SoftwareDistribution\Download\*.*" >nul 2>&1
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Windows\WebCache\*.*" >nul 2>&1
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.*" >nul 2>&1
del /S /F /Q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>&1
del /S /F /Q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache\*.*" >nul 2>&1
call :Log "Optimization" "DeleteTempFiles"
echo Done.
call :Pause2
goto :eof

:OptimizeNetwork
echo Flushing DNS cache...
ipconfig /flushdns >nul 2>&1
echo Setting Cloudflare DNS on the active adapter...
for /f "tokens=* delims=:" %%A in ('ipconfig ^| findstr /I "Ethernet adapter"') do (
    set "ADAPTERNAME=%%A"
)
if defined ADAPTERNAME (
    set "ADAPTERNAME=!ADAPTERNAME:~17!"
    netsh interface ipv4 set dns name="!ADAPTERNAME!" static 1.1.1.1 primary >nul 2>&1
    netsh interface ipv4 add dns name="!ADAPTERNAME!" 1.0.0.1 index=2 >nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\QoS" /v LimitReservableBandwidth /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v GlobalMaxTcpWindowSize /t REG_DWORD /d 0x7FFF /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v TCP1323opts /t REG_DWORD /d 1 /f >nul
call :Log "Optimization" "OptimizeNetwork"
echo Done.
call :Pause2
goto :eof

:CleanCache
echo Cleaning caches...
del /q /f "%temp%\*.*" >nul 2>&1
ipconfig /flushdns >nul 2>&1
del /q /f "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*" >nul 2>&1
start /wait wsreset.exe
call :Log "Optimization" "CleanCache"
echo Done.
call :Pause2
goto :eof

:DefragDisk
echo WARNING: Only run this on HDDs, not SSDs.
set /p DD_DRIVE="Drive letter to defragment (e.g. C): "
if not exist "%DD_DRIVE%:\" (
    echo That drive does not exist.
    call :Pause2
    goto :eof
)
defrag %DD_DRIVE%: /O /H
call :Log "Optimization" "DefragDisk_%DD_DRIVE%"
call :Pause2
goto :eof

:CheckDisk
set /p CD_DRIVE="Drive letter to check (e.g. C): "
if not exist "%CD_DRIVE%:\" (
    echo That drive does not exist.
    call :Pause2
    goto :eof
)
chkdsk %CD_DRIVE%: /f
call :Log "Optimization" "CheckDisk_%CD_DRIVE%"
call :Pause2
goto :eof

:ManageStartup
echo Current startup programs:
echo ==================================================
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
echo ==================================================
set /p SU_PROG="Program name to remove (or 'all'): "
if /I "%SU_PROG%"=="all" (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f >nul 2>&1
    echo All startup entries removed.
) else (
    reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%SU_PROG%" /f
)
call :Log "Optimization" "ManageStartup_%SU_PROG%"
call :Pause2
goto :eof

:UpdateDrivers
echo 1 - AMD
echo 2 - Intel
echo 3 - NVIDIA
echo 4 - HP
echo 5 - Lenovo
echo 6 - Asus
echo 7 - Acer
echo 8 - Back
set /p UD_OP="Option: "
if "%UD_OP%"=="1" start https://www.amd.com/en/support
if "%UD_OP%"=="2" start https://www.intel.com/content/www/us/en/support/detect.html
if "%UD_OP%"=="3" start https://www.nvidia.com/Download/index.aspx
if "%UD_OP%"=="4" start https://support.hp.com/us-en/drivers
if "%UD_OP%"=="5" start https://support.lenovo.com/us/en
if "%UD_OP%"=="6" start https://www.asus.com/support/download-center/
if "%UD_OP%"=="7" start https://www.acer.com/support
call :Log "Optimization" "UpdateDrivers"
goto :eof

:RepairSystemFiles
sfc /scannow
call :Log "Optimization" "SFCScan"
call :Pause2
goto :eof

:DisableNotifications
powershell -NoProfile -Command "Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -Value 0"
call :Log "Optimization" "DisableNotifications"
call :Pause2
goto :eof

:RestartExplorer
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 /nobreak >nul
start explorer.exe
call :Log "Optimization" "RestartExplorer"
call :Pause2
goto :eof

:DeleteMemoryDumps
if exist "%SystemDrive%\Memory.dmp" del /f /q "%SystemDrive%\Memory.dmp"
if exist "%WINDIR%\Minidump\*" del /f /q "%WINDIR%\Minidump\*"
call :Log "Optimization" "DeleteMemoryDumps"
call :Pause2
goto :eof

:DisableFileIndexing
net stop "Windows Search" >nul 2>&1
sc config "WSearch" start= disabled >nul 2>&1
call :Log "Optimization" "DisableFileIndexing"
call :Pause2
goto :eof

:DeleteFailedUpdates
net stop wuauserv >nul 2>&1
del /f /s /q "%WINDIR%\SoftwareDistribution\Download\*" >nul 2>&1
del /f /s /q "%WINDIR%\SoftwareDistribution\DataStore\*" >nul 2>&1
net start wuauserv >nul 2>&1
call :Log "Optimization" "DeleteFailedUpdates"
call :Pause2
goto :eof

:RunDiskCleanup
cleanmgr /sagerun:1
call :Log "Optimization" "RunDiskCleanup"
call :Pause2
goto :eof

:DisableMSSync
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AccountSettings" /v DisableMicrosoftAccountSync /t REG_DWORD /d 1 /f >nul
call :Log "Optimization" "DisableMSSync"
call :Pause2
goto :eof

:DisableFullScreenOpti
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f >nul
call :Log "Optimization" "DisableFullScreenOpti"
call :Pause2
goto :eof

:DisableBackgroundApps
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul
call :Log "Optimization" "DisableBackgroundApps"
call :Pause2
goto :eof

:ReduceSvchost
call :GetTotalMemoryKB
set /a RAM_THRESHOLD=RAM_KB + 1024000
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d %RAM_THRESHOLD% /f >nul
call :Log "Optimization" "ReduceSvchost"
call :Pause2
goto :eof

:GetTotalMemoryKB
set "RAM_KB=8000000"
for /f "tokens=4" %%A in ('systeminfo ^| findstr /C:"Total Physical Memory"') do set "RAM_TXT=%%A"
if defined RAM_TXT (
    set "RAM_TXT=%RAM_TXT:,=%"
    set "RAM_TXT=%RAM_TXT:MB=%"
    set /a RAM_KB=RAM_TXT*1024 2>nul
)
goto :eof

:DisableGameDVR
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_DXGIHonorFSEWindowsCompatible /t REG_DWORD /d 1 /f >nul
call :Log "Optimization" "DisableGameDVR"
call :Pause2
goto :eof

:DisableWindowTransparency
reg add "HKCU\Software\Microsoft\Windows\DWM" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
call :Log "Optimization" "DisableWindowTransparency"
call :Pause2
goto :eof

:DisableHardwareAcceleration
reg add "HKCU\Software\Microsoft\Avalon.Graphics" /v DisableHWAcceleration /t REG_DWORD /d 1 /f >nul
call :Log "Optimization" "DisableHardwareAcceleration"
call :Pause2
goto :eof

:LaunchTool
set "TL_NAME=%~1"
set "TL_PATH=%~2"
if exist "%~dp0%TL_PATH%" (
    start "" "%~dp0%TL_PATH%"
    call :Log "Tools" "Launch_%TL_NAME%"
) else (
    echo %TL_NAME% was not found in %TL_PATH%.
    call :Pause2
)
goto :eof

:ClearOptiToolLogs
if exist "logs" del /q "logs\*.log" >nul 2>&1
echo OptiTool logs cleared.
call :Pause2
goto :eof

:ViewCurrentLog
if "%CFG_DISABLE_LOGS%"=="1" (
    echo Logging is disabled in info\config.txt.
    call :Pause2
    goto :eof
)
if not exist "%LOGFILE%" (
    echo No active log file was found for this session.
    call :Pause2
    goto :eof
)
start "" notepad "%LOGFILE%"
goto :eof

:LaunchIRM
set "IRM_NAME=%~1"
set "IRM_URL=%~2"
echo.
echo WARNING: you are about to download and run a remote script:
echo   Name: %IRM_NAME%
echo   URL:  %IRM_URL%
echo Only continue if you trust the source of this script.
set /p IRM_CONFIRM="Continue? (Y/N): "
if /I not "%IRM_CONFIRM%"=="Y" goto :eof
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm '%IRM_URL%' | iex"
call :Log "IRM" "Launch_%IRM_NAME%"
call :Pause2
goto :eof

:EnsurePrograms
if exist "info\programs.txt" goto :eof
(
    echo # OptiTool recommended-programs installer list
    echo # Format: Name=InstallerPath=SilentArgs
    echo # SilentArgs is optional; defaults to /S if left empty
    echo # Examples:
    echo # 7-Zip=installers\7zip.exe=/S
    echo # VLC=installers\vlc.exe=/L=1033 /S
) > "info\programs.txt"
goto :eof

:InstallRecommendedPrograms
call :EnsurePrograms
echo.
echo Installing recommended programs...
for /f "usebackq eol=# tokens=1,2,* delims==" %%A in ("info\programs.txt") do (
    if not "%%A"=="" (
        set "PR_NAME=%%A"
        set "PR_PATH=%%B"
        set "PR_ARGS=%%C"
        if "!PR_ARGS!"=="" set "PR_ARGS=/S"
        if exist "!PR_PATH!" (
            echo   - Installing !PR_NAME!...
            if /I "!PR_PATH:~-4!"==".msi" (
                if "!PR_ARGS!"=="/S" set "PR_ARGS=/qn /norestart"
                start "" /wait msiexec /i "!PR_PATH!" !PR_ARGS!
            ) else (
                start "" /wait "!PR_PATH!" !PR_ARGS!
            )
            call :Log "Programs" "Installed_!PR_NAME!"
        ) else (
            echo   - !PR_NAME! skipped ^(installer not found: !PR_PATH!^)
        )
    )
)
echo Recommended programs step finished.
goto :eof

:DisableDefender
echo.
echo WARNING: disabling Windows Defender lowers your system's protection.
set /p DD_CONFIRM="Continue? (Y/N): "
if /I not "%DD_CONFIRM%"=="Y" goto :eof
if exist "resources\Defender\DisableDefender.reg" (
    regedit /S "resources\Defender\DisableDefender.reg"
) else (
    echo resources\Defender\DisableDefender.reg was not found.
)
call :Log "Security" "DisableDefender"
echo Done. A restart may be required.
call :Pause2
goto :eof

:EnableDefender
if exist "resources\Defender\Undo.reg" (
    regedit /S "resources\Defender\Undo.reg"
) else (
    echo resources\Defender\Undo.reg was not found.
)
call :Log "Security" "EnableDefender"
echo Done. A restart may be required.
call :Pause2
goto :eof

:CheckDefenderStatus
powershell -NoProfile -Command "try { if ((Get-MpComputerStatus).RealTimeProtectionEnabled) { Write-Host 'Windows Defender: ENABLED' } else { Write-Host 'Windows Defender: DISABLED' } } catch { Write-Host 'Could not read Windows Defender status.' }"
call :Pause2
goto :eof

:DisableCpuMitigations
echo WARNING: this disables Spectre/Meltdown side-channel protections
echo for a CPU performance gain, and lowers your security margin
echo against those specific attacks. A restart is required.
set /p CM_CONFIRM="Continue? (Y/N): "
if /I not "%CM_CONFIRM%"=="Y" goto :eof
if exist "cpu\DisableMitigations.reg" regedit /S "cpu\DisableMitigations.reg"
call :Log "Advanced" "DisableCpuMitigations"
echo Done. Restart your PC to apply this change.
call :Pause2
goto :eof

:EnableCpuMitigations
if exist "cpu\EnableMitigations.reg" regedit /S "cpu\EnableMitigations.reg"
call :Log "Advanced" "EnableCpuMitigations"
echo Done. Restart your PC to apply this change.
call :Pause2
goto :eof

:RemoveBloatApps
echo This removes pre-installed Windows apps (Store excluded) for the
echo current user. Most can be reinstalled later from the Microsoft
echo Store if you change your mind.
set /p BA_CONFIRM="Continue? (Y/N): "
if /I not "%BA_CONFIRM%"=="Y" goto :eof
powershell -NoProfile -Command "Get-AppxPackage | Where-Object { $_.Name -notlike '*store*' } | Remove-AppxPackage -ErrorAction SilentlyContinue"
call :Log "Advanced" "RemoveBloatApps"
echo Done.
call :Pause2
goto :eof

:CleanupWinSxS
echo Running the Microsoft-supported WinSxS component cleanup.
echo This only removes superseded component versions that Windows
echo itself has already marked as safe to remove; it does not take
echo ownership of or force-delete anything.
Dism /Online /Cleanup-Image /StartComponentCleanup
call :Log "Advanced" "CleanupWinSxS"
call :Pause2
goto :eof

:CleanReg
reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU "%USERPROFILE%\Desktop\RunMRU_Backup.reg" /y
reg export "HKCU\Software\Microsoft\Internet Explorer" "%USERPROFILE%\Desktop\InternetExplorer_Backup.reg" /y
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "%USERPROFILE%\Desktop\ShellFolders_Backup.reg" /y

reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /f
reg delete "HKCU\Software\Microsoft\Internet Explorer\TypedURLs" /f
reg delete "HKCU\Software\Microsoft\Internet Explorer\LowRegistry\Run" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f
reg delete "HKCU\Software\Microsoft\Search\RecentQueries" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\WindowsUpdate" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\SearchHistory" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f

call :Log "Advanced" "CleanReg"
call :Pause2
goto :eof

:: MIT