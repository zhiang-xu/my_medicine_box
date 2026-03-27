@echo off
chcp 65001 >nul
echo ========================================
echo 开始构建 APK (终极版)
echo ========================================
echo.

cd /d "%~dp0"
echo 当前目录: %CD%
echo.

echo 步骤 1: 检查 Java 版本...
java -version
echo.

echo 步骤 2: 清理 Flutter 缓存...
call flutter clean
echo.

echo 步骤 3: 安装依赖...
call flutter pub get
echo.

echo ========================================
echo 步骤 4: 开始构建 APK
echo ========================================
echo.
echo 提示:
echo - 已配置国内镜像源
echo - 已清理所有旧缓存
echo - 首次构建可能需要 5-10 分钟
echo - 请耐心等待...
echo.

set GRADLE_OPTS=-Dgradle.user.home=c:\Users\zhangxu\.gradle
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
