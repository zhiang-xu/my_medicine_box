@echo off
setlocal enabledelayedexpansion

echo.
echo ========================================
echo Push to GitHub
echo ========================================
echo.

echo [Step 1] Checking git status...
git status

echo.
echo [Step 2] Adding files...
git add .

echo.
echo [Step 3] Committing changes...
git commit -m "Initial commit" || echo [Warning] Nothing to commit or commit failed

echo.
echo [Step 4] Pushing to GitHub...
git push -u origin main

echo.
echo ========================================
echo Done!
echo ========================================
echo.

pause
