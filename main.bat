@echo off
title Doom Installer
echo Doom 1 and 2 Installer.
timeout /t 1 > nul

cls
echo Do you want to install Doom (yes or no)? : 
set /p "yesorno="
if /i "%yesorno%" == "yes" (goto :install)
exit

:install
echo Where do you want to install doom? (if none specified, using %userprofile%\doom): 
set /p "wheretoplace="
if "%wheretoplace%" == "" (
    set "wheretoplace=%userprofile%\doom"
)
echo Using %wheretoplace% ...
mkdir "%wheretoplace%"

echo Downloading https://github.com/ZDoom/gzdoom/releases/download/g4.12.2/gzdoom-4-12-2-Windows.zip ...

powershell -Command "Invoke-WebRequest https://github.com/ZDoom/gzdoom/releases/download/g4.12.2/gzdoom-4-12-2-Windows.zip -OutFile '%wheretoplace%\GZDoom.zip'"

echo Done.

echo Extracting it ...
mkdir "%wheretoplace%\GZDoomEngine"
powershell -Command "Expand-Archive '%wheretoplace%\GZDoom.zip' -DestinationPath '%wheretoplace%\GZDoomEngine\'"

echo Done.

echo Downloading the game files (Doom 1 is https://github.com/Akbar30Bill/DOOM_wads/raw/master/doom1.wad and Doom 2 is https://github.com/Akbar30Bill/DOOM_wads/raw/master/doom2.wad) ...
powershell -Command "Invoke-WebRequest https://github.com/Akbar30Bill/DOOM_wads/raw/master/doom1.wad -OutFile '%wheretoplace%\GZDoomEngine\doom1.wad'"
powershell -Command "Invoke-WebRequest https://github.com/Akbar30Bill/DOOM_wads/raw/master/doom2.wad -OutFile '%wheretoplace%\GZDoomEngine\doom2.wad'"

echo Done.

echo The files are placed where they are ment to be.

echo Copying the Config ...

mkdir "%useprofile%\Documents\My Games\GZDoom"
copy "%cd%\gzdoom.ini" "%userprofile%\Documents\My Games\GZDoom\gzdoom.ini"

echo Making the shortcut ...

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%userprofile%\desktop\Doom.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%wheretoplace%\GZDoomEngine\gzdoom.exe" >> %SCRIPT%
echo oLink.IconLocation = "%wheretoplace%\GZDoomEngine\gzdoom.exe" >> %SCRIPT%
echo oLink.WorkingDirectory = "%wheretoplace%\GZDoomEngine" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%
echo Done.
pause > nul
echo Press any key to exit...
exit
