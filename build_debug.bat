@echo off
echo ====================================
echo 构建 Debug 版本 APK（更容易成功）
echo ====================================
echo.

echo [1/4] 清理缓存...
flutter clean
echo.

echo [2/4] 安装依赖...
flutter pub get
echo.

echo [3/4] 构建 Debug APK...
flutter build apk --debug
echo.

if exist build\app\outputs\flutter-apk\app-debug.apk (
    echo [4/4] 构建成功！
    echo APK 位置: build\app\outputs\flutter-apk\app-debug.apk
    for %%I in (build\app\outputs\flutter-apk\app-debug.apk) do echo APK 大小: %%~zI 字节
) else (
    echo [4/4] 构建失败！
    echo.
    echo 请检查上面的错误信息
)

echo.
pause
