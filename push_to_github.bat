@echo off
chcp 65001 >nul
echo ========================================
echo 上传代码到 GitHub Actions 构建
echo ========================================
echo.

set GITHUB_USERNAME=zhiang-xu

echo [警告] 重要提示：
echo 1. 请将此脚本中的 YOUR_USERNAME 替换为你的 GitHub 用户名
echo 2. 确保 GitHub 用户名是正确的
echo.

echo 当前配置的 GitHub 用户名: %GITHUB_USERNAME%
echo.

set /p confirm="用户名正确吗？(Y/N): "
if /i not "%confirm%"=="Y" (
    echo.
    echo 请编辑此文件，将 YOUR_USERNAME 替换为你的实际 GitHub 用户名
    pause
    exit /b 1
)

echo.
echo ========================================
echo 步骤 1: 检查 Git
echo ========================================
git --version 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [错误] Git 未安装！
    echo 请访问 https://git-scm.com/downloads 下载安装
    pause
    exit /b 1
)
echo [OK] Git 已安装
echo.

cd /d "%~dp0"

echo ========================================
echo 步骤 2: 初始化 Git 仓库
echo ========================================
if exist ".git" (
    echo [OK] Git 仓库已初始化
) else (
    git init
    echo [OK] Git 仓库已初始化
)
echo.

echo ========================================
echo 步骤 3: 创建 .gitignore
echo ========================================
(
echo build/
echo *.apk
echo .dart_tool/
echo .flutter-plugins-dependencies
echo .flutter-plugins
echo .packages
echo .metadata
echo pubspec.lock
echo android/.gradle/
echo android/local.properties
echo android/.idea/
echo android/build/
echo android/app/build/
echo *.iml
echo .idea/
) > .gitignore
echo [OK] .gitignore 已创建
echo.

echo ========================================
echo 步骤 4: 添加文件到 Git
echo ========================================
git add . 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] 文件已添加
) else (
    echo [警告] 添加文件时出现警告
)
echo.

echo ========================================
echo 步骤 5: 提交文件
echo ========================================
git commit -m "Initial commit" 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] 已提交
) else (
    echo [警告] 提交时出现警告或无变更
)
echo.

echo ========================================
echo 步骤 6: 添加远程仓库
echo ========================================
git remote add origin https://github.com/%GITHUB_USERNAME%/my_medicine_box.git 2>nul
git remote set-url origin https://github.com/%GITHUB_USERNAME%/my_medicine_box.git
echo [OK] 远程仓库已配置
echo.

echo ========================================
echo 步骤 7: 推送到 GitHub
echo ========================================
echo 正在推送代码到: https://github.com/%GITHUB_USERNAME%/my_medicine_box
echo.
git branch -M main 2>&1
git push -u origin main 2>&1

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo [成功] 推送成功！
    echo ========================================
    echo.
    echo 请访问以下地址:
    echo https://github.com/%GITHUB_USERNAME%/my_medicine_box
    echo.
    echo 下一步:
    echo 1. 访问上述地址
    echo 2. 点击 "Actions" 标签
    echo 3. 选择 "Build APK" workflow
    echo 4. 点击 "Run workflow" 手动触发构建
    echo 5. 等待 5-10 分钟
    echo 6. 构建完成后下载 APK
    echo.
) else (
    echo.
    echo ========================================
    echo [失败] 推送失败！
    echo ========================================
    echo.
    echo 可能的原因:
    echo 1. 仓库名称或用户名错误
    echo 2. 需要认证（GitHub Personal Access Token）
    echo.
    echo 解决方案:
    echo 1. 确保在 GitHub 上已创建仓库 my_medicine_box
    echo 2. 访问 https://github.com/settings/tokens 创建 token
    echo 3. 推送时使用 token 作为密码
    echo.
)

pause
