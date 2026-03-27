@echo off
echo.
echo ========================================
echo Git Proxy Configuration
echo ========================================
echo.
echo 请选择你使用的代理软件和端口:
echo.
echo 1. Clash - 7890
echo 2. Clash - 7891
echo 3. Clash Verge - 7897
echo 4. V2RayN - 10809
echo 5. 自定义端口
echo 6. 取消
echo.

set /p choice=请输入选项 (1-6):

if "%choice%"=="1" set PORT=7890
if "%choice%"=="2" set PORT=7891
if "%choice%"=="3" set PORT=7897
if "%choice%"=="4" set PORT=10809
if "%choice%"=="5" (
    set /p PORT=请输入代理端口:
)
if "%choice%"=="6" (
    echo 已取消
    pause
    exit /b
)

echo.
echo 配置 Git 使用代理 127.0.0.1:%PORT%...

git config --global http.proxy http://127.0.0.1:%PORT%
git config --global https.proxy http://127.0.0.1:%PORT%

echo.
echo [OK] 代理已配置
echo.
echo 测试连接...
ping -n 2 github.com >nul 2>&1
if errorlevel 1 (
    echo [警告] 仍然无法连接 GitHub，请确保:
    echo 1. 代理软件正在运行
    echo 2. 允许局域网连接已开启
) else (
    echo [OK] 可以连接 GitHub
)
echo.

pause
