@echo off
chcp 65001 >nul
echo ========================================
echo 开始构建 APK (使用国内镜像)
echo ========================================
echo.

cd /d "%~dp0"
echo 当前目录: %CD%
echo.

echo 步骤 1: 检查 Java 版本...
java -version
echo.

echo 步骤 2: 停止 Gradle 守护进程...
cd android
call gradlew --stop 2>nul
cd ..
echo Gradle 守护进程已停止
echo.

echo 步骤 3: 清理 Flutter 缓存...
call flutter clean
echo.

echo 步骤 4: 安装依赖...
call flutter pub get
echo.

echo ========================================
echo 步骤 5: 开始构建 APK
echo ========================================
echo.
echo 提示:
echo - 已配置国内镜像源，下载速度会更快
echo - 首次构建可能仍需要 5-10 分钟
echo - 请耐心等待...
echo.

call flutter build apk --release
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
