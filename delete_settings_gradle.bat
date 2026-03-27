@echo off
echo.
echo ========================================
echo Fix settings.gradle
echo ========================================
echo.

echo [Step 1] Deleting android/settings.gradle...
del /F /Q "android\settings.gradle"

echo.
echo [Step 2] Checking git status...
git status

echo.
echo [Step 3] Committing changes...
git add .
git commit -m "Fix: Remove corrupted settings.gradle"

echo.
echo [Step 4] Pushing to GitHub...
git push

echo.
echo ========================================
echo Done!
echo ========================================
echo.
echo Check build status at:
echo https://github.com/zhiang-xu/my_medicine_box/actions
echo.

pause
