@echo off
chcp 65001 >nul
echo ========================================
echo 测试 Gradle 使用的 Java 版本
echo ========================================
echo.

cd /d "%~dp0android"
echo 当前目录: %CD%
echo.

echo 步骤 1: 显示系统 Java 版本...
java -version
echo.

echo 步骤 2: 显示 JAVA_HOME...
echo JAVA_HOME=%JAVA_HOME%
echo.

echo 步骤 3: 显示 gradle.properties 中的 Java 配置...
findstr "org.gradle.java.home" gradle.properties
echo.

echo 步骤 4: 测试 Gradle...
echo 正在运行 Gradle 任务...
call gradlew -version
echo.

echo ========================================
echo 测试完成
echo ========================================
echo.
pause
