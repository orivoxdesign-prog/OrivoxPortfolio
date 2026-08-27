@echo off
echo Installation de Git...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.45.0.windows.1/Git-2.45.0-64-bit.exe' -OutFile '%temp%\GitInstaller.exe'; & '%temp%\GitInstaller.exe' /VERYSILENT /NORESTART"
echo Installation terminée ! Redemarrez votre terminal PowerShell.
pause
