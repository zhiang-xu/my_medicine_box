@echo off
setlocal enabledelayedexpansion

echo.
echo ========================================
echo Push to GitHub - Final Version
echo ========================================
echo.

echo [Step 1] Configuring Git user...
git config --global user.name "zhiang-xu"
git config --global user.email "zhiang-xu@users.noreply.github.com"
echo [OK] Git configured

echo.
echo [Step 2] Checking git status...
git status

echo.
echo [Step 3] Adding files...
git add .

echo.
echo [Step 4] Committing changes...
git commit -m "Initial commit"

echo.
echo [Step 5] Pushing to GitHub...
git push -u origin main

echo.
echo ========================================
echo Done!
echo ========================================
echo.

pause
