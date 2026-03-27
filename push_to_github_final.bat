@echo off
echo.
echo ========================================
echo Push to GitHub for Building APK
echo ========================================
echo.

echo [Step 1] Checking git status...
git status

echo.
echo [Step 2] Adding all files...
git add .

echo.
echo [Step 3] Committing changes...
git commit -m "Fix: Update Android configuration for Flutter 3.41 compatibility"

echo.
echo [Step 4] Pushing to GitHub...
git push

echo.
echo ========================================
echo Done! Check build status at:
echo https://github.com/zhiang-xu/my_medicine_box/actions
echo ========================================
echo.

pause
