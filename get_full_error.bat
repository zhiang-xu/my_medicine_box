@echo off
chcp 65001 >nul
echo ====================================
echo 获取完整错误日志
echo ====================================
echo.

echo 正在清理并重新构建，请稍候...
echo.

flutter clean >nul 2>&1
flutter pub get >nul 2>&1

echo.
echo 开始构建...
echo.
echo ====================================
echo 构建输出（将保存到 full_build_log.txt）
echo ====================================
echo.

flutter build apk --release --verbose > full_build_log.txt 2>&1

echo.
if exist full_build_log.txt (
    echo ====================================
    echo 构建日志已保存到: full_build_log.txt
    echo ====================================
    echo.

    echo 显示最后 50 行错误信息：
    echo ====================================
    powershell -Command "Get-Content full_build_log.txt | Select-Object -Last 50"

    echo.
    echo ====================================
    echo 完整错误日志：
    echo ====================================
    type full_build_log.txt
) else (
    echo ERROR: 无法生成日志文件
)

echo.
echo ====================================
echo 按任意键打开日志文件...
echo ====================================
pause >nul
start notepad full_build_log.txt
