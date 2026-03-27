# 我的药物箱 - Android 应用

一款家庭药品管理应用，帮助您轻松管理家庭药箱中的药品信息。

## 功能特点

### 📸 拍照录入
- 拍摄药品包装正面，自动识别药品名称、品牌
- 拍摄有效期信息，自动识别生产日期和有效期
- 支持多角度拍摄补充信息
- 手动编辑和补充药品信息

### 📊 智能统计
- 药品总数统计
- 即将过期药品提醒（默认30天内）
- 已过期药品标记
- 按成员查看录入统计

### 🔍 快速搜索
- 支持按药品名称、品牌、分类搜索
- 搜索结果展示库存状态
- 一键跳转网上搜索详细信息

### 📋 药品管理
- 查看药品详细信息
- 更新剩余药量
- 标记药品状态（用完、损坏、丢弃、过期）
- 删除药品记录

### 👨‍👩‍👧‍👦 家庭管理
- 添加和管理家庭成员
- 按成员查看录入记录
- 统计每个成员的药品录入数量

### ⏰ 过期提醒
- 自定义提前提醒天数
- 自定义提醒时间
- 支持开启/关闭提醒功能

## 技术架构

- **开发框架**: Flutter 3.x
- **开发语言**: Dart
- **数据库**: SQLite (sqflite)
- **状态管理**: Provider
- **OCR识别**: Google ML Kit (可配置)
- **图片处理**: image_picker, camera
- **本地通知**: flutter_local_notifications

## 项目结构

```
lib/
├── main.dart                      # 应用入口
├── models/                        # 数据模型
│   ├── medicine.dart
│   ├── user.dart
│   └── medicine_image.dart
├── database/                      # 数据库
│   ├── database_helper.dart
│   ├── medicine_dao.dart
│   ├── user_dao.dart
│   └── medicine_image_dao.dart
├── providers/                     # 状态管理
│   ├── medicine_provider.dart
│   └── settings_provider.dart
├── screens/                       # 页面
│   ├── home_screen.dart
│   ├── photo_entry_screen.dart
│   ├── medicine_detail_screen.dart
│   ├── search_result_screen.dart
│   ├── profile_screen.dart
│   ├── member_manage_screen.dart
│   └── settings_screen.dart
└── widgets/                       # 组件
    ├── stat_card.dart
    ├── medicine_card.dart
    └── bottom_nav.dart
```

## 快速开始

### 前置要求

- Flutter SDK 3.x
- Android SDK
- Android Studio 或 VS Code

### 安装步骤

1. **安装 Flutter**
   ```bash
   # 访问 https://flutter.dev/docs/get-started/install/windows 下载并安装
   flutter --version
   flutter doctor
   ```

2. **进入项目目录**
   ```bash
   cd my_medicine_box
   ```

3. **安装依赖**
   ```bash
   flutter pub get
   ```

4. **运行应用**
   ```bash
   flutter run
   ```

### 构建 APK

```bash
# Debug 版本
flutter build apk --debug

# Release 版本
flutter build apk --release

# 分架构构建（减小APK大小）
flutter build apk --release --split-per-abi
```

详细构建指南请参考 [BUILD_APK.md](BUILD_APK.md)

## 应用截图

### 首页
展示药品统计、即将过期提醒和药品列表

### 拍照录入
引导用户拍摄药品照片并录入信息

### 药品详情
查看药品完整信息并进行操作

### 我的
查看家庭信息和统计数据

### 家庭成员管理
添加和管理家庭成员

### 设置
配置过期提醒等应用设置

## 数据库设计

### medicines 表
存储药品的所有信息，包括名称、品牌、分类、数量、有效期等

### users 表
存储家庭成员信息，支持管理员和普通成员角色

### medicine_images 表
存储药品的图片信息，支持多张图片

## 待优化功能

- [ ] 集成真实 OCR 识别服务
- [ ] 添加云同步功能
- [ ] 支持用药提醒
- [ ] 添加数据导出功能
- [ ] 支持药品分享功能
- [ ] 添加数据分析报表
- [ ] 支持多语言
- [ ] 优化 UI/UX

## 注意事项

### OCR 识别
当前版本使用模拟的 OCR 识别。如需真实 OCR 功能，建议使用：
- Google ML Kit Text Recognition API
- 百度 OCR
- 腾讯 OCR
- 阿里云 OCR

### 权限说明
应用需要以下权限：
- **相机权限**: 拍摄药品照片
- **存储权限**: 保存和读取图片
- **通知权限**: 发送过期提醒

### 数据隐私
- 所有数据存储在本地 SQLite 数据库
- 不会上传到任何服务器
- 用户可以随时删除所有数据

## 常见问题

**Q: 如何修改应用名称？**
A: 编辑 `android/app/src/main/AndroidManifest.xml` 中的 `android:label`

**Q: 如何修改应用图标？**
A: 替换 `android/app/src/main/res/mipmap-*` 目录下的图标文件

**Q: OCR 识别不准确怎么办？**
A: 可以在录入后手动编辑药品信息，或者集成更强大的 OCR 服务

**Q: 如何备份数据？**
A: 未来版本将添加数据导出功能，当前可以导出数据库文件

## 开发者

- 开发者: 个人自研
- 版本: 1.0.0
- 更新日期: 2024-03-27

## 许可证

本项目为个人自研项目，仅供个人家庭使用。

## 相关文档

- [快速开始指南](QUICK_START.md)
- [APK 构建指南](BUILD_APK.md)
- [项目结构说明](PROJECT_STRUCTURE.md)
- [原型图设计](../我的药物箱-产品原型图.pptx)

## 联系方式

如有问题或建议，欢迎反馈。
"# my_medicine_box" 
