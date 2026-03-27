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
git commit -m "Fix: Use latest stable Flutter version"

echo.
echo [Step 3] Pushing to GitHub...
git push

echo.
echo ========================================
echo Done!
echo ========================================
echo.

pause
