# Build APK Script
echo.
echo ========================================
echo Build APK (Debug)
echo ========================================
echo.

echo [Step 1] Clean...
if exist build\app\outputs\flutter-apk\app-release.apk del /F /Q build\app\outputs\flutter-apk\app-release.apk

echo.
echo [Step 2] Get dependencies...
flutter pub get

echo.
echo [Step 3] Build APK...
flutter build apk --debug

echo.
echo [Step 4] Show result...
if exist build\app\outputs\flutter-apk\app-debug.apk (
    echo.
    echo ========================================
    echo BUILD SUCCESSFUL!
    echo APK location: build\app\outputs\flutter-apk\app-debug.apk
    echo ========================================
) else (
    echo.
    echo ========================================
    echo BUILD FAILED!
    echo ========================================
)

echo.
pause
