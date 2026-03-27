@echo off
echo.
echo ========================================
echo Clean Gradle Cache
echo ========================================
echo.

echo [Step 1] Stopping Gradle daemons...
taskkill /F /IM java.exe 2>nul
taskkill /F /IM gradle.exe 2>nul
timeout /t 2 >nul

echo.
echo [Step 2] Cleaning build directories...
if exist build rmdir /s /q build
if exist android\build rmdir /s /q android\build
if exist android\.gradle rmdir /s /q android\.gradle

echo.
echo [Step 3] Cleaning local Gradle cache...
if exist %USERPROFILE%\.gradle\caches rmdir /s /q %USERPROFILE%\.gradle\caches
if exist %USERPROFILE%\.gradle\daemon rmdir /s /q %USERPROFILE%\.gradle\daemon

echo.
echo [OK] Clean completed
echo.

pause
