@echo off
echo.
echo ========================================
echo Push Fix to GitHub
echo ========================================
echo.

echo [Step 1] Checking for changes...
git status

echo.
echo [Step 2] Adding files...
git add .

echo.
echo [Step 3] Committing changes...
git commit -m "Fix: Migrate to declarative Gradle plugins for Flutter 3.41"

echo.
echo [Step 4] Pushing to GitHub...
git push

echo.
echo ========================================
echo Done! Check GitHub Actions:
echo https://github.com/zhiang-xu/my_medicine_box/actions
echo ========================================
echo.

pause
