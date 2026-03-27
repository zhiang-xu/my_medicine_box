@echo off
chcp 65001 >nul
echo ========================================
echo 彻底清理所有缓存
echo ========================================
echo.

echo 步骤 1: 停止所有 Gradle 守护进程...
taskkill /F /IM java.exe 2>nul
echo 所有 Java 进程已停止
echo.

echo 步骤 2: 停止 Gradle 守护进程...
cd "%~dp0android"
call gradlew --stop 2>nul
cd ..
echo Gradle 守护进程已停止
echo.

echo 步骤 3: 等待 2 秒...
timeout /t 2 /nobreak >nul
echo.

echo 步骤 4: 删除整个 .gradle 目录...
if exist "%USERPROFILE%\.gradle" (
    echo 正在删除 %USERPROFILE%\.gradle
    takeown /f "%USERPROFILE%\.gradle" /r /d y >nul 2>&1
    icacls "%USERPROFILE%\.gradle" /grant administrators:F /t >nul 2>&1
    rd /s /q "%USERPROFILE%\.gradle"
    echo .gradle 目录已删除
)
echo.

echo 步骤 5: 删除 Flutter build 目录...
if exist "%~dp0build" (
    rd /s /q "%~dp0build"
    echo build 目录已删除
)
echo.

echo 步骤 6: 删除 Flutter .dart_tool 目录...
if exist "%~dp0.dart_tool" (
    rd /s /q "%~dp0.dart_tool"
    echo .dart_tool 目录已删除
)
echo.

echo 步骤 7: 删除 Android build 目录...
if exist "%~dp0android\.gradle" (
    rd /s /q "%~dp0android\.gradle"
    echo android\.gradle 目录已删除
)
if exist "%~dp0android\build" (
    rd /s /q "%~dp0android\build"
    echo android\build 目录已删除
)
echo.

echo ========================================
echo 清理完成！
echo ========================================
echo.
echo 请按任意键继续构建 APK...
pause >nul
