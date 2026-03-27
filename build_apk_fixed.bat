@echo off
echo ========================================
echo 开始构建 APK
echo ========================================
echo.

cd /d "%~dp0"
echo 当前目录: %CD%
echo.

echo 步骤 1: 检查 Java 版本...
java -version
echo.

echo 步骤 2: 清理 Gradle 缓存...
if exist "%USERPROFILE%\.gradle" (
    echo 删除 %USERPROFILE%\.gradle
    rd /s /q "%USERPROFILE%\.gradle"
    echo Gradle 缓存已清理
)
echo.

echo 步骤 3: 清理 Flutter 缓存...
call flutter clean
echo.

echo 步骤 4: 安装依赖...
call flutter pub get
echo.

echo 步骤 5: 开始构建 APK (这可能需要 10-20 分钟)...
call flutter build apk --release --verbose
echo.

if %ERRORLEVEL% EQU 0 (
    echo ========================================
    echo 构建成功！
    echo ========================================
    echo.
    echo APK 文件位置:
    echo %CD%\build\app\outputs\flutter-apk\app-release.apk
    echo.
    dir "%CD%\build\app\outputs\flutter-apk\app-release.apk"
) else (
    echo ========================================
    echo 构建失败！
    echo ========================================
    echo 请查看上面的错误信息
)

echo.
pause
