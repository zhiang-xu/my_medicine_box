@echo off
chcp 65001 >nul
echo ========================================
echo 使用强制 Java 11 构建 APK
echo ========================================
echo.

cd /d "%~dp0"
echo 当前目录: %CD%
echo.

echo 步骤 1: 设置 JAVA_HOME...
set JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-11.0.30.7-hotspot
echo JAVA_HOME=%JAVA_HOME%
echo.

echo 步骤 2: 检查 Java 版本...
"%JAVA_HOME%\bin\java.exe" -version
echo.

echo 步骤 3: 停止所有 Gradle 守护进程...
cd android
call gradlew --stop 2>nul
cd ..
echo.

echo 步骤 4: 清理 Flutter 缓存...
call flutter clean
echo.

echo 步骤 5: 安装依赖...
call flutter pub get
echo.

echo ========================================
echo 步骤 6: 开始构建 APK
echo ========================================
echo.
echo 提示:
echo - 已强制使用 JDK 11
echo - 配置了国内镜像源
echo - 请耐心等待 5-10 分钟
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
)

echo.
pause
