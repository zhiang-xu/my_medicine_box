@echo off
chcp 65001 >nul
echo.
echo ========================================
echo Git Proxy Configuration
echo ========================================
echo.
echo Please select your proxy software and port:
echo.
echo 1. Clash - 7890
echo 2. Clash - 7891
echo 3. Clash Verge - 7897
echo 4. V2RayN - 10809
echo 5. Custom port
echo 6. Cancel
echo.

set /p choice=Please enter option (1-6):

if "%choice%"=="1" set PORT=7890
if "%choice%"=="2" set PORT=7891
if "%choice%"=="3" set PORT=7897
if "%choice%"=="4" set PORT=10809
if "%choice%"=="5" (
    set /p PORT=Please enter proxy port:
)
if "%choice%"=="6" (
    echo Cancelled
    pause
    exit /b
)

echo.
echo Configuring Git proxy 127.0.0.1:%PORT%...

git config --global http.proxy http://127.0.0.1:%PORT%
git config --global https.proxy http://127.0.0.1:%PORT%

echo.
echo [OK] Proxy configured
echo.
echo Testing connection...
ping -n 2 github.com >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Still cannot connect to GitHub, please ensure:
    echo 1. Proxy software is running
    echo 2. Allow LAN connection is enabled
) else (
    echo [OK] Can connect to GitHub
)
echo.

pause
