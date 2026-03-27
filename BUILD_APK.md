# APK 构建指南

## 环境准备

### 1. 安装 Flutter SDK

从 [Flutter官网](https://flutter.dev/docs/get-started/install/windows) 下载并安装 Flutter SDK。

安装完成后，在终端运行以下命令验证安装：
```bash
flutter --version
flutter doctor
```

### 2. 安装 Android SDK

确保已安装 Android Studio 或 Android SDK Command-line Tools。

运行 `flutter doctor` 检查是否需要安装 Android SDK。

### 3. 安装依赖

在项目根目录运行：
```bash
flutter pub get
```

## 构建 APK

### Debug 版本（用于测试）

```bash
flutter build apk --debug
```

生成的 APK 文件位于：
`build/app/outputs/flutter-apk/app-debug.apk`

### Release 版本（用于发布）

```bash
flutter build apk --release
```

生成的 APK 文件位于：
`build/app/outputs/flutter-apk/app-release.apk`

### 分架构构建（减小 APK 大小）

```bash
# ARM64 (64位设备)
flutter build apk --release --target-platform android-arm64

# ARM (32位设备)
flutter build apk --release --target-platform android-arm

# 两个都打包
flutter build apk --release --split-per-abi
```

## 配置应用签名（Release 版本）

### 1. 生成签名密钥

在 Java 环境中运行：
```bash
keytool -genkey -v -keystore ~/my-medicine-box-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my_medicine_box
```

### 2. 创建 keystore.properties 文件

在 `android/` 目录下创建 `keystore.properties` 文件：
```
storePassword=你的密码
keyPassword=你的密码
keyAlias=my_medicine_box
storeFile=/path/to/your/my-medicine-box-key.jks
```

### 3. 配置 android/app/build.gradle

在 android/app/build.gradle 中添加：
```gradle
def keystorePropertiesFile = rootProject.file("keystore.properties")
def keystoreProperties = new Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

## 测试 APK

### 在模拟器上运行
```bash
flutter emulators
flutter emulator --launch <emulator_id>
flutter run
```

### 在真机上运行
1. 在手机上启用开发者选项和 USB 调试
2. 使用 USB 连接手机
3. 运行：
```bash
flutter devices
flutter run
```

### 安装 APK 到手机
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

## 常见问题

### 1. Flutter 找不到 SDK
确保已配置 Flutter 环境变量：
```bash
# Windows
setx PATH "%PATH%;C:\path\to\flutter\bin"

# 或者临时设置
set PATH=%PATH%;C:\path\to\flutter\bin
```

### 2. 构建失败：缺少 Android SDK
安装 Android Studio 并确保已安装必要的 SDK 组件。

### 3. 权限问题
确保已在 AndroidManifest.xml 中声明了相机、存储等权限。

### 4. OCR 识别
当前代码使用模拟的 OCR 识别。如需真实 OCR 功能，需要：
- 集成 Google ML Kit Text Recognition API
- 或使用第三方 OCR 服务（如百度 OCR、腾讯 OCR）

## 下一步

1. 在真机上测试应用
2. 根据测试结果优化功能
3. 准备应用截图和描述
4. 上传到应用商店（可选）
