@echo off
echo ========================================
echo Fix Git Tracking for settings.gradle
echo ========================================
echo.

echo [Step 1] Check git status...
git status

echo.
echo [Step 2] Remove settings.gradle from .gitignore...
if exist .gitignore (
    findstr /i /v "settings.gradle" .gitignore > .gitignore.tmp
    move /y .gitignore.tmp .gitignore >nul
    echo [OK] Removed settings.gradle from .gitignore
) else (
    echo [WARNING] .gitignore not found
)

echo.
echo [Step 3] Check if android/settings.gradle exists...
if exist android\settings.gradle (
    echo [OK] android/settings.gradle exists
) else (
    echo [ERROR] android/settings.gradle not found!
    echo Please make sure the file exists before running this script.
    pause
    exit /b 1
)

echo.
echo [Step 4] Add settings.gradle to git...
git add -f android\settings.gradle

echo.
echo [Step 5] Commit changes...
git commit -m "Fix: Track android/settings.gradle in git"

echo.
echo [Step 6] Push to GitHub...
git push

echo.
echo ========================================
echo Done!
echo ========================================
echo.

pause
