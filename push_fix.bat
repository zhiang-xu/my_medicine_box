@echo off
setlocal enabledelayedexpansion

echo.
echo ========================================
echo Push Fix to GitHub
echo ========================================
echo.

echo [Step 1] Adding files...
git add .

echo.
echo [Step 2] Committing changes...
git commit -m "Fix: Update Gradle to 8.9 and AGP to 8.7.3 for Flutter 3.41"

echo.
echo [Step 3] Pushing to GitHub...
git push

echo.
echo ========================================
echo Done!
echo ========================================
echo.

pause
