@echo off
REM Copyright 2024 The Flutter Authors. All rights reserved.
REM Use of this source code is governed by a BSD-style license that can be
REM found in the LICENSE file.

REM This script runs the Flutter build command for the debug mode.

setlocal enabledelayedexpansion

REM Validate the arguments.
set "BUILD_MODE=debug"
if "%~1" == "" (
  set "BUILD_MODE=debug"
) else if "%~1" == "debug" (
  set "BUILD_MODE=debug"
) else if "%~1" == "profile" (
  set "BUILD_MODE=profile"
) else if "%~1" == "release" (
  set "BUILD_MODE=release"
) else (
  goto USAGE
)

REM Check if the git repository has pending changes.
set "HAS_CHANGES=0"
for /f "usebackq tokens=2" %%a in (`git status --porcelain 2^>nul`) do (
  set "HAS_CHANGES=1"
)

REM If there are pending changes, push them to GitHub.
if %HAS_CHANGES%==1 (
  echo.
  echo ========================================
  echo Pushing changes to GitHub
  echo ========================================
  echo.
  echo [Step 1] Checking for changes...
  git status

  echo.
  echo [Step 2] Adding files...
  git add .

  echo.
  echo [Step 3] Committing changes...
  git commit -m "Build: %BUILD_MODE%"

  echo.
  echo [Step 4] Pushing to GitHub...
  git push
)

REM Run the Flutter build command.
echo.
echo ========================================
echo Building %BUILD_MODE% APK
echo ========================================
echo.

call "%~dp0\flutter_wrapper.bat" build apk --%BUILD_MODE%

REM Check the build result.
if %ERRORLEVEL% NEQ 0 (
  echo.
  echo ========================================
  echo Build failed!
  echo ========================================
  exit /b 1
) else (
  echo.
  echo ========================================
  echo Build successful!
  echo APK location: build\app\outputs\flutter-apk\app-%BUILD_MODE%.apk
  echo ========================================
)

exit /b 0

:USAGE
echo.
echo Usage: build_debug.bat [debug|profile|release]
echo.
echo Arguments:
echo   debug    Build a debug APK (default)
echo   profile  Build a profile APK
echo   release  Build a release APK
echo.
exit /b 1

:ERROR
echo.
echo ========================================
echo Build failed!
echo ========================================
exit /b 1
