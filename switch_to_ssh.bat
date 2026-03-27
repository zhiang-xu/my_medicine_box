@echo off
echo.
echo ========================================
echo Switch to SSH Remote
echo ========================================
echo.

echo Creating SSH directory if not exists...
if not exist "%USERPROFILE%\.ssh" (
    mkdir "%USERPROFILE%\.ssh"
    echo SSH directory created
)

echo Checking SSH key...
if not exist "%USERPROFILE%\.ssh\id_rsa.pub" (
    echo SSH key not found. Generating...
    ssh-keygen -t rsa -b 4096 -C "zhiang-xu@github.com" -f "%USERPROFILE%\.ssh\id_rsa" -N ""
    echo.
    echo SSH key generated!
) else (
    echo SSH key found
)

echo.
echo Your SSH public key:
echo.
type "%USERPROFILE%\.ssh\id_rsa.pub"
echo.
echo ========================================
echo.
echo Next steps:
echo 1. Copy the SSH key above
echo 2. Go to https://github.com/settings/ssh/new
echo 3. Paste the key and save
echo 4. Run this script again
echo.
pause

echo.
echo Testing SSH connection...
echo yes | ssh -T git@github.com

echo.
echo Switching remote to SSH...
git remote set-url origin git@github.com:zhiang-xu/my_medicine_box.git

echo.
echo [OK] Remote switched to SSH
echo.

pause
