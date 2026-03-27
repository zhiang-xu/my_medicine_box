@echo off
echo ====================================================
echo 我的药物箱 - APK 快速构建脚本
echo ====================================================
echo.

echo [1/5] 检查 Flutter 环境...
flutter --version
if errorlevel 1 (
    echo ERROR: Flutter 未安装或未配置 PATH
    pause
    exit /b 1
)
echo Flutter 环境正常
echo.

echo [2/5] 清理之前的构建...
flutter clean
if exist .flutter-plugins del .flutter-plugins
if exist .flutter-plugins-dependencies del .flutter-plugins-dependencies
echo 清理完成
echo.

echo [3/5] 检查依赖...
flutter pub get
if errorlevel 1 (
    echo ERROR: 依赖安装失败
    pause
    exit /b 1
)
echo 依赖检查完成
echo.

echo [4/5] 构建 APK (这可能需要几分钟，请耐心等待)...
echo.
echo 注意: 首次构建可能需要 10-20 分钟
echo.
flutter build apk --release --verbose
if errorlevel 1 (
    echo ERROR: 构建失败
    echo.
    echo 请查看上面的错误信息
    pause
    exit /b 1
)
echo.

echo [5/5] 检查生成的 APK...
if exist build\app\outputs\flutter-apk\app-release.apk (
    echo.
    echo ====================================================
    echo 构建成功！
    echo ====================================================
    echo APK 位置: build\app\outputs\flutter-apk\app-release.apk
    for %%I in (build\app\outputs\flutter-apk\app-release.apk) do echo APK 大小: %%~zI 字节
    echo ====================================================
    echo.
) else (
    echo ERROR: 未找到生成的 APK 文件
    echo 请检查上面的错误信息
    pause
    exit /b 1
)

echo 按任意键退出...
pause >nul
