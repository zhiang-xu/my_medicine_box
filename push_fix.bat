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
git commit -m "Fix: Update Flutter to 3.24.5 and upload-artifact to v4"

echo.
echo [Step 3] Pushing to GitHub...
git push

echo.
echo ========================================
echo Done!
echo ========================================
echo.

pause
