@echo off
SETLOCAL

echo Starting POS Upgrade Process.
echo Restaurant Number: %RestaurantNumber:~2,4%

set /a debug=0
If /i "%1" EQU "debug" (set /a debug=1) Else (set /a debug=0)

set oldPos=v6.7.70
set oldAk=v12.2.54.13
set oldAto=v15.2.4.246
set oldEdc=v15.1.17.15
set oldAtg=N/A
set oldRal=v17.6.2.12
set oldMP=v16.1.138.0

set newPos=v15.1.21.0
set newAk=v16.2.2.33
set newAto=v15.2.25.478
set newEdc=no-change
set newAtg=v18.2.2.793
set newRal=no-change
set newMP=v17.2.22.0

set "thisFileName=installQdoba_POS15.1.bat"
set /a filenamedate=%date:~10,4%%date:~4,2%%date:~7,2%
set filenametime=%time:~0,2%%time:~3,2%
set filenametime=%filenametime: =0%

set LogLocation=D:\Support\Aloha15
set LogName=posUpgrade.%filenamedate%.%filenametime%.LOG
set PortsName=posOpenPorts.%filenamedate%.%filenametime%.LOG
set CopiesName=posCopyFiles.%filenamedate%.%filenametime%.LOG
set LogFile=%LogLocation%\%LogName%
set LogPorts=%LogLocation%\%PortsName%
set LogCopies=%LogLocation%\%CopiesName%

set IberDir=D:\AlohaQs
set singleLine=-----------------------------------------------------------------------------
set mediumLine=-----------------------------------------------
set shortLine=-----------------------------------
set tinyLine=-------------



:: === HEADER ===
call :header>>%LogFile% 2>>&1


:nextDeleteDeltrackFiles
echo.
echo Delete Deltrack Files from D: Drive
echo Working...
if %debug% EQU 1 (pause)
call :runDeleteDeltrackFiles>>%LogFile% 2>>&1
echo Complete.

:nextBackupMpConfig
echo.
echo Backup Mobile Pay Config to LOG folder
If %debug% EQU 1 (Pause)
echo Working...
call :runBackupMpConfig>>%LogFile% 2>>&1
echo Complete.


:nextPOSUpgrade
echo.
echo Upgrade POS
If %debug% EQU 1 (Pause)
echo Working...
call :runPOSUpgrade>>%LogFile% 2>>&1
echo Complete.


:nextStartAtgService
echo.
echo Start ATG Service
If %debug% EQU 1 (Pause)
echo Working...
call :runStartAtgService>>%LogFile% 2>>&1
echo Complete.


REM :nextCopyMpManifest
REM echo.
REM echo Copy Mobile Pay Manifest to Installers folder
REM If %debug% EQU 1 (Pause)
REM echo Working...
REM call :runCopyMpManifest>>%LogFile% 2>>&1
REM echo Complete.



REM :nextMpUninstall
REM echo.
REM echo Mobile Pay Uninstall
REM If %debug% EQU 1 (Pause)
REM echo Working...
REM call :runMpUninstall>>%LogFile% 2>>&1
REM echo Complete.



echo Waiting TWELVE minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting ELEVEN minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting TEN minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting NINE minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting EIGHT minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting SEVEN minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting SIX minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting FIVE minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting FOUR minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting THREE minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting TWO minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting ONE minute before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1



:nextRebootFoh
echo Reboot FOH
echo wait until terminals are floating (unless there is a RAL or another Error)
If %debug% EQU 1 (Pause)
call :runRebootFoh>>%LogFile% 2>>&1
echo Complete.


echo Waiting SIXTEEN minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting FIFTEEN minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting FOURTEEN minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting THIRTEEN minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting TWELVE minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting ELEVEN minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting TEN minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting NINE minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting EIGHT minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting SEVEN minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting SIX minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting FIVE minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting FOUR minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting THREE minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting TWO minutes before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting ONE minute before Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Complete.




:nextMobilePayUpgrade
echo.
echo Upgrade MobilePay
If %debug% EQU 1 (Pause)
echo Working...
call :runMobilePayUpgrade>>%LogFile% 2>>&1

echo Waiting one minute after Mobile Pay Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Complete.


REM :nextCopyMpConfig
REM echo.
REM echo Copy Mobile Pay Config to BIN folder
REM If %debug% EQU 1 (Pause)
REM echo Working...
REM call :runCopyMpConfig>>%LogFile% 2>>&1
REM echo Complete.


:nextCopyNewMpManifest
echo.
echo Copy Mobile Pay Manifest to Installers folder
If %debug% EQU 1 (Pause)
echo Working...
call :runCopyNewMpManifest>>%LogFile% 2>>&1
echo Complete.


:nextLoyaltyUpgrade
echo.
echo Upgrade Loyalty
If %debug% EQU 1 (Pause)
echo Working...
call :runLoyaltyUpgrade>>%LogFile% 2>>&1
echo Complete.


echo Waiting two minutes after Loyalty Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting one more minute after Loyalty Upgrade
call :waitOneMinute>>%LogFile% 2>>&1
echo Complete.


:nextInsightUpgrade
echo.
echo Upgrade Insight
If %debug% EQU 1 (Pause)
echo Working...
call :runInsightUpgrade>>%LogFile% 2>>&1
echo Complete.
echo.
echo.


REM Added this for Mobile Pay Upgrade
echo Waiting FIVE minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting FOUR minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting THREE minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting TWO minutes before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1
echo Waiting ONE minute before FOH reboot
call :waitOneMinute>>%LogFile% 2>>&1

:nextRebootFoh
echo Reboot FOH
echo wait until terminals are floating (unless there is a RAL or another Error)
If %debug% EQU 1 (Pause)
call :runRebootFoh>>%LogFile% 2>>&1
echo Complete.



echo Press any key to finish (Finishing)
If %debug% EQU 1 (Pause)
echo Exiting.


REM ***FINISH WITHOUT REBOOTING FOH NOR BOH***
:: === FOOTER ===
call :footer>>%LogFile% 2>>&1


exit
REM ***DO NOT GO PAST HERE***
goto:EOF


:nextReboot
::REM Wait 18 minutes before reboot - to allow terminals to float
::REM ping 127.0.0.1 -n 1080>nul
REM echo.
REM echo do you need to restart the BOH?
REM set /p bohreboot=Reboot BOH Now? (y/n): 
REM echo Bypassing restart of the BOH and Exiting...
REM set bohreboot=n
REM call :runReboot>>"D:\Support\Aloha15\posUpgrade.%filenamedate%.%filenametime%.LOG" 2>>&1
REM echo Complete.


exit /b 0
goto:EOF


::====================================================================================::
::====================================================================================::


:waitOneMinute
echo %filenamedate% %time% [INFO]: Waiting one minute before Next Action
ping 127.0.0.1 -n 59>nul
goto:EOF


::====================================================================================::
::====================================================================================::


:header
echo %filenamedate% %time% [INFO]: START %thisFileName%
echo =============================================================================
echo %filenamedate% %time% [INFO]: Restaurant Number: %RestaurantNumber:~2,4%
echo %filenamedate% %time% [INFO]: %mediumLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:footer
echo %filenamedate% %time% [INFO]: 
echo %filenamedate% %time% [INFO]: %mediumLine%
echo %filenamedate% %time% [INFO]: Restaurant Number: %RestaurantNumber:~2,4%
echo %filenamedate% %time% [INFO]: POS UPGRADE PROCESS COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumLine%
echo %filenamedate% %time% [INFO]: Exiting new_installQdoba_POS15.1.bat
echo %filenamedate% %time% [INFO]: %mediumLine%
echo =============================================================================
goto:EOF


::====================================================================================::
::====================================================================================::


:runDeleteDeltrackFiles
::======= Remove Deltrack Markers ========
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Delete Deltrack Markers from D: Drive
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: START REMOVE DELTRACK MARKERS SECTION
pushd \ 
del /s /f /q DELTRACK
echo %filenamedate% %time% [INFO]: REMOVING DELTRACK FILES COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF



::====================================================================================::
::====================================================================================::


:runBackupMpConfig
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Backup MPAgent.exe.setting.config file from BIN to this LOG Folder
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: BACKING UP MP CONFIG...
robocopy %IBERDIR%\BIN %LogLocation%\ MPAgent.exe.setting.config
echo %filenamedate% %time% [INFO]: BACKING UP MP CONFIG SEGMENT COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runPOSUpgrade
::================== NCR POS UPGRADE =================================================
echo %singleLine%
echo %filenamedate% %time% [INFO]: Begin NCR Upgrade of POS (Aloha Suite Installer)
echo %singleLine%
echo %filenamedate% %time% [INFO]: 
echo %filenamedate% %time% [INFO]: Current Versions:
echo %filenamedate% %time% [INFO]: %shortLine%
echo %filenamedate% %time% [INFO]: POS %oldPos%
echo %filenamedate% %time% [INFO]: AK  %oldAk%
echo %filenamedate% %time% [INFO]: ATO %oldAto%
echo %filenamedate% %time% [INFO]: EDC %oldEdc%
echo %filenamedate% %time% [INFO]: ATG %oldAtg%
echo %filenamedate% %time% [INFO]: RAL %oldRal%
echo %filenamedate% %time% [INFO]: 
echo %filenamedate% %time% [INFO]: Upgraded Versions:
echo %filenamedate% %time% [INFO]: %shortLine%
echo %filenamedate% %time% [INFO]: POS %newPos%
echo %filenamedate% %time% [INFO]: AK  %newAk%
echo %filenamedate% %time% [INFO]: ATO %newAto%
echo %filenamedate% %time% [INFO]: EDC %newEdc%
echo %filenamedate% %time% [INFO]: ATG %newAtg%
echo %filenamedate% %time% [INFO]: RAL %newRal%
echo %filenamedate% %time% [INFO]: 
echo %filenamedate% %time% [INFO]: START: AlohaSuiteInstaller.exe

start /wait %LogLocation%\AlohaSuiteInstaller.exe /q

echo %filenamedate% %time% [INFO]: 
echo %filenamedate% %time% [INFO]: POS UPGRADE COMPLETE.
echo %singleLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runMpUninstall
::======= Run MobilePay Uninstall ========
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Run MobilePay Uninstall
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: START MOBILE PAY UNINSTALL SECTION
call msiexec /x MobilePay.msi /qf
echo %filenamedate% %time% [INFO]: MOBILE PAY UNINSTALL SECTION COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runMobilePayUpgrade
::======= Run MobilePay Upgrade ========
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Run MobilePay Upgrade, %newMP%
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: START MOBILE PAY UPGRADE SECTION
REM call msiexec /i "D:\AlohaQS\ftp\MobilePay_v17\MobilePay.msi" /l* MPQS.Install.log /quiet SERVICETYPE=qs HOSTNAME=ncrpay.com PROTOCOL=https PORT=443 ENABLE_BARCODE=1
REM call MPQS-oneclick.bat
start /wait MPQS-un-re-inst.bat
echo %filenamedate% %time% [INFO]: MOBILE PAY UPGRADE SECTION COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runLoyaltyUpgrade
::======= Run Loyalty Upgrade ========
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Run Loyalty Upgrade, v13.5.5.2 rev4
echo %filenamedate% %time% [INFO]: %mediumeLine%
set IberDir=D:\AlohaQs
echo %filenamedate% %time% [INFO]: START LOYALTY UPGRADE SECTION
pushd D:\Support\Aloha15
call D:\Support\Aloha15\ALinst.exe
echo %filenamedate% %time% [INFO]: LOYALTY UPGRADE SECTION COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runInsightUpgrade
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Run Insight Upgrade, v15.9.1.2
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: START INSIGHT UPGRADE SEGMENT
echo %filenamedate% %time% [INFO]: set IBERDIR
set IberDir=D:\AlohaQS
echo %filenamedate% %time% [INFO]: Check EGrind and GenPoll File Sizes
dir D:\AlohaQS\ftp\EGrind*
dir D:\AlohaQS\ftp\GenPoll*
echo %filenamedate% %time% [INFO]: Installing...
pushd D:\Support\Aloha15
call InsightInstall.exe /upgrade
echo %filenamedate% %time% [INFO]: Check EGrind and GenPoll File Sizes again
echo %filenamedate% %time% [INFO]: (These should be larger)
dir D:\AlohaQS\ftp\EGrind*
dir D:\AlohaQS\ftp\GenPoll*
echo %filenamedate% %time% [INFO]: INSIGHT UPGRADE SECTION COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runStartAtgService
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Assign and Start ATG Service
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: START ATG SERVICE SEGMENT
echo %filenamedate% %time% [INFO]: change ATG user to Local System Account
SC CONFIG ATGService obj= ".\LocalSystem" password= ""
echo %filenamedate% %time% [INFO]: Starting ATG Service...
net start ATGService
echo %filenamedate% %time% [INFO]: START ATG SERVICE SEGMENT COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runCopyMpConfig
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Copying MPAgent.exe.setting.config file from this LOG Folder to BIN
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: COPYING MP CONFIG...
robocopy %LogLocation%\ %IBERDIR%\BIN MPAgent.exe.setting.config
echo %filenamedate% %time% [INFO]: COPYING MP CONFIG SEGMENT COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runCopyMpManifest
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Copy Mobile Pay Manifest File to Installers Folder
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: COPYING MANIFEST...
robocopy %LogLocation%\ D:\AlohaQS\Installers\ MobilePay.FOH.Manifest.xml
echo %filenamedate% %time% [INFO]: COPYING MP MANIFEST SEGMENT COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::


:runCopyNewMpManifest
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: Copy Mobile Pay Manifest File to Installers Folder
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: COPYING MANIFEST...
robocopy %IBERDIR%\BIN D:\AlohaQS\Installers\ MobilePay.FOH.Manifest.xml
echo %filenamedate% %time% [INFO]: COPYING MP MANIFEST SEGMENT COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF


::====================================================================================::
::====================================================================================::



:runRebootFoh
::======= Reboot Terminals =======
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: REBOOT FRONT-of-HOUSE
echo %filenamedate% %time% [INFO]: %mediumeLine%

set Restaurant=%RestaurantNumber:~2,4%
set uname=Term1
set pass=Tuser123!
FOR /L %%G in (1,1,5) DO call :REBOOTforFohOnly %%G
set tname=
set uname=
set pass=

echo %filenamedate% %time% [INFO]: REBOOT FRONT-of-HOUSE COMPLETE.
echo %filenamedate% %time% [INFO]: %mediumeLine%
echo %filenamedate% %time% [INFO]: 
goto:EOF



:REBOOTforFohOnly
set WSname=%Restaurant%WS%1
set KSname=%Restaurant%KS%1
echo shutdown -r -f -t 5 -m \\%WSname%
NET USE \\%WSname%\IPC$ /user:%uname% %pass%
psexec \\%WSname% -s -i -d shutdown -r -f -t 10
echo shutdown -r -f -t 5 -m \\%KSname%
NET USE \\%KSname%\IPC$ /user:%uname% %pass%
psexec \\%KSname% -s -i -d shutdown -r -f -t 10
goto :EOF



::====================================================================================::
::====================================================================================::



:runRebootBoh
ENDLOCAL
::======= Reboot after Upgrade =======
echo -----------------------------------------------------------------------------
echo See if BOH needs to be rebooted
echo START: %date%, %time%
echo -----------------------------------------------------------------------------
if /I %bohreboot%==y echo Rebooting BOH... & shutdown /r /f /t 15
echo.
echo COMPLETE: %date%, %time%
echo -----------------------------------------------------------------------------
echo.
echo.
echo Exiting.
echo %date%, %time%
echo -----------------------------------------------------------------------------
echo =============================================================================
goto:EOF


::======= EXIT =======
exit /b 0








