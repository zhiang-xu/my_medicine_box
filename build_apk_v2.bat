@echo off
chcp 65001 >nul
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

echo 步骤 2: 停止 Gradle 守护进程...
call gradlew --stop 2>nul
echo Gradle 守护进程已停止
echo.

echo 步骤 3: 删除 Gradle 锁文件...
echo 正在删除 Gradle 锁文件...
del /f /q "%USERPROFILE%\.gradle\caches\8.0\EXECUT~1\executionHistory.lock" 2>nul
del /f /q "%USERPROFILE%\.gradle\caches\8.0\FILECO~1\fileContent.lock" 2>nul
del /f /q "%USERPROFILE%\.gradle\caches\8.0\FILEHA~1\fileHashes.lock" 2>nul
del /f /q "%USERPROFILE%\.gradle\caches\JOURNA~1\journal-1.lock" 2>nul
del /f /q "%USERPROFILE%\.gradle\caches\MODULE~1\modules-2.lock" 2>nul
echo 锁文件已删除
echo.

echo 步骤 4: 删除 Gradle daemon...
rd /s /q "%USERPROFILE%\.gradle\daemon" 2>nul
echo Gradle daemon 已删除
echo.

echo 步骤 5: 删除 Gradle native...
rd /s /q "%USERPROFILE%\.gradle\native" 2>nul
echo Gradle native 已删除
echo.

echo 步骤 6: 清理 Flutter 缓存...
call flutter clean
echo.

echo 步骤 7: 安装依赖...
call flutter pub get
echo.

echo ========================================
echo 步骤 8: 开始构建 APK
echo 这可能需要 10-20 分钟，请耐心等待...
echo ========================================
echo.

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
