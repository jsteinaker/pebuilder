@echo off

:: Some environment variables
set arch=amd64
set language=es-es
set root=D:\pebuilder
set peroot=%root%\winpe
set files=%root%\files
set imagepath=%peroot%\%arch%\media\sources\boot.wim
set mountpath=%peroot%\%arch%\mount
set ADK=C:\Program Files (x86)\Windows Kits\8.1\Assessment and Deployment Kit\Windows Preinstallation Environment\%arch%

:: Mounted images cleanup.
imagex /cleanup

:: Clean the destination directory, if exists.
rd /s /q %peroot%\%arch%

:: The image is created...
CALL copype %arch% %peroot%\%arch%

:: ...and mounted
imagex /mountrw %imagepath% 1 %mountpath%

:: LanguagePack and WinPE-HTA (Victoria needs it)
::dism /Image:"%mountpath%" /Add-Package /PackagePath:"%ADK%\WinPE_OCs\%language%\lp.cab"
::dism /Image:"%mountpath%" /Add-Package /PackagePath:"%ADK%\WinPE_OCs\WinPE-HTA.cab"
::dism /Image:"%mountpath%" /Add-Package /PackagePath:"%ADK%\WinPE_OCs\%language%\WinPE-HTA_%language%.cab"

:: Manual file copy (in this tree, we have scripts, tools, etc)
xcopy %files%\%arch% %mountpath% /E

:: Unmount the image, saving changes
imagex /unmount %mountpath% /commit
