@echo off
chcp 65001 >nul
echo ========================================
echo 使用 verbose 模式构建
echo ========================================
echo.

cd /d "%~dp0"
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-11.0.30.7-hotspot

echo 正在构建，会显示详细日志...
echo 如果看到很多 "Task :" 和编译输出，说明在正常运行
echo.

call flutter build apk --release --verbose 2>&1

echo.
echo ========================================
if %ERRORLEVEL% EQU 0 (
    echo 构建成功！
    echo.
    dir "%CD%\build\app\outputs\flutter-apk\app-release.apk"
) else (
    echo 构建失败，错误代码: %ERRORLEVEL%
)
pause
