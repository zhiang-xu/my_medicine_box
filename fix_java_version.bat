@echo off
chcp 65001 >nul
echo ====================================
echo Java 版本检查和修复工具
echo ====================================
echo.

echo [1/6] 检查当前 Java 版本...
java -version 2>&1 | findstr /i "version"
if errorlevel 1 (
    echo ERROR: Java 未安装
    pause
    exit /b 1
)
echo.

echo [2/6] 检查 CLASS file major version...
java -version 2>&1 | findstr /i "version" > java_ver.txt
for /f "tokens=3" %%i in ('type java_ver.txt ^| findstr /i "version"') do set JAVA_VER=%%i
set JAVA_VER=%JAVA_VER:"=%
echo 当前 Java 版本: %JAVA_VER%
del java_ver.txt

echo.
echo 如果显示 21.x，说明 Java 版本太高！
echo 需要安装 JDK 11 或 17
echo.

echo [3/6] 检查 JAVA_HOME...
if "%JAVA_HOME%"=="" (
    echo WARNING: JAVA_HOME 未设置
) else (
    echo JAVA_HOME=%JAVA_HOME%
)
echo.

echo [4/6] 检查 PATH 中的 Java...
where java
echo.

echo [5/6] 清理 Gradle 缓存...
if exist C:\Users\zhangxu\.gradle\caches (
    echo 正在清理 Gradle 缓存...
    rd /s /q C:\Users\zhangxu\.gradle\caches
    echo Gradle 缓存已清理
) else (
    echo Gradle 缓存不存在，无需清理
)
echo.

echo [6/6] 清理 Flutter 缓存...
cd c:\Users\zhangxu\CodeBuddy\20260327173322\my_medicine_box
flutter clean
echo Flutter 缓存已清理
echo.

echo ====================================
echo 修复完成
echo ====================================
echo.
echo 接下来的步骤：
echo.
echo 1. 如果当前 Java 版本是 21.x：
echo    - 下载并安装 JDK 11: https://adoptium.net/temurin/releases/?version=11
echo    - 设置 JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-11.x
echo    - 将 %JAVA_HOME%\bin 添加到 PATH 最前面
echo    - 重启命令行窗口
echo.
echo 2. 验证 Java 版本:
echo    java -version
echo    应该显示 11.x 或 17.x
echo.
echo 3. 重新构建 APK:
echo    flutter build apk --release
echo.
pause
