@echo off
chcp 65001 >nul
echo ========================================
echo 开始构建 APK
echo ========================================
echo.
echo Java 版本:
java -version
echo.
echo 当前目录:
cd
echo.
echo ========================================
echo 构建中...请耐心等待 5-10 分钟
echo ========================================
echo.

cd /d "%~dp0"
call flutter build apk --release

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo 构建成功！
    echo ========================================
    echo.
    echo APK 文件位置:
    echo %CD%\build\app\outputs\flutter-apk\app-release.apk
    echo.
    dir "%CD%\build\app\outputs\flutter-apk\app-release.apk"
) else (
    echo.
    echo ========================================
    echo 构建失败！
    echo ========================================
)

echo.
pause
