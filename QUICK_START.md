# 快速开始指南

## 第一步：安装 Flutter

### Windows 系统

1. 下载 Flutter SDK
   - 访问 https://flutter.dev/docs/get-started/install/windows
   - 下载 Flutter SDK zip 包

2. 解压并配置环境变量
   ```bash
   # 解压到 C:\flutter（或你喜欢的位置）
   # 添加到系统环境变量 PATH:
   # C:\flutter\bin
   ```

3. 验证安装
   ```bash
   flutter --version
   flutter doctor
   ```

4. 安装 Android SDK
   - 下载并安装 Android Studio
   - 在 Android Studio 中安装 Android SDK
   - 运行 `flutter doctor` 检查

## 第二步：准备项目

1. 进入项目目录
   ```bash
   cd c:\Users\zhangxu\CodeBuddy\20260327173322\my_medicine_box
   ```

2. 安装依赖
   ```bash
   flutter pub get
   ```

## 第三步：运行应用

### 在模拟器上运行

1. 启动 Android 模拟器
   ```bash
   flutter emulators --launch <emulator_id>
   ```

2. 运行应用
   ```bash
   flutter run
   ```

### 在真机上运行

1. 在手机上启用开发者选项和 USB 调试
2. 使用 USB 连接手机
3. 运行
   ```bash
   flutter run
   ```

## 第四步：构建 APK

### Debug 版本（用于测试）
```bash
flutter build apk --debug
```
生成的文件：`build/app/outputs/flutter-apk/app-debug.apk`

### Release 版本（用于发布）
```bash
flutter build apk --release
```
生成的文件：`build/app/outputs/flutter-apk/app-release.apk`

## 应用功能说明

### 核心功能

1. **首页**
   - 查看药品统计（总数、即将过期、已过期）
   - 查看即将过期的药品提醒
   - 浏览最近录入的药品列表
   - 搜索药品

2. **拍照录入**
   - 拍摄药品包装正面（识别药品名称、品牌）
   - 拍摄有效期（识别生产日期和有效期）
   - 拍摄其他角度作为补充
   - 手动编辑药品信息
   - 保存到数据库

3. **药品详情**
   - 查看药品完整信息
   - 更新剩余药量
   - 更新药品状态（用完、损坏、丢弃、过期）
   - 删除药品记录
   - 搜索网上药品信息

4. **我的**
   - 查看家庭信息和统计
   - 管理家庭成员
   - 应用设置

5. **设置**
   - 开启/关闭过期提醒
   - 设置提前提醒天数
   - 设置提醒时间

### 数据存储

- 所有数据存储在本地 SQLite 数据库
- 支持家庭成员管理
- 支持药品图片存储

## 注意事项

### OCR 识别
当前代码中 OCR 识别功能是模拟的。如需真实 OCR 功能：

1. **使用 Google ML Kit Text Recognition**
   - 已在 pubspec.yaml 中添加依赖
   - 需要在 AndroidManifest.xml 中添加配置
   - 参考 Google ML Kit 文档集成

2. **使用第三方 OCR 服务**
   - 百度 OCR
   - 腾讯 OCR
   - 阿里云 OCR
   - 需要申请 API Key

### 权限说明
应用需要以下权限（已在 AndroidManifest.xml 中声明）：
- 相机权限：拍摄药品照片
- 存储权限：保存和读取图片
- 通知权限：发送过期提醒

### 后续功能建议
1. 添加云同步功能
2. 完善OCR识别
3. 添加用药提醒功能
4. 支持药品分享功能
5. 添加数据分析报表
6. 支持多语言

## 常见问题

### Q: Flutter doctor 显示错误怎么办？
A: 根据错误提示安装缺失的依赖，通常是 Android SDK 或 Java JDK

### Q: 应用无法打开相机怎么办？
A: 确保已在 AndroidManifest.xml 中声明相机权限，并在真机上授权

### Q: 如何修改应用名称和图标？
A:
- 修改名称：编辑 `android/app/src/main/AndroidManifest.xml` 中的 `android:label`
- 修改图标：替换 `android/app/src/main/res/mipmap-*` 目录下的图标文件

### Q: 如何减小 APK 大小？
A: 使用 `--split-per-abi` 参数构建分架构的 APK：
```bash
flutter build apk --release --split-per-abi
```

## 技术支持

如有问题，请参考：
- Flutter 官方文档：https://flutter.dev/docs
- pub.dev：https://pub.dev
- 项目文档：BUILD_APK.md、PROJECT_STRUCTURE.md
