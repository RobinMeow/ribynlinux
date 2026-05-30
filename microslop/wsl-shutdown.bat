@echo off
echo Shutting down WSL...

wsl --shutdown

echo Done! Closing window...
REM timeout /t 2 >nul
REM right click, create shortcut. right click on shotcut, target: prepend cmd.exe /c
REM e.g. target:
REM cmd.exe /c "path\to\file.bat"
