# 项目结构说明

```
my_medicine_box/
├── lib/
│   ├── main.dart                      # 应用入口
│   │
│   ├── models/                        # 数据模型层
│   │   ├── medicine.dart              # 药品模型
│   │   ├── user.dart                  # 用户模型
│   │   └── medicine_image.dart        # 药品图片模型
│   │
│   ├── database/                      # 数据库层
│   │   ├── database_helper.dart       # 数据库帮助类
│   │   ├── medicine_dao.dart          # 药品数据访问对象
│   │   ├── user_dao.dart              # 用户数据访问对象
│   │   └── medicine_image_dao.dart    # 药品图片数据访问对象
│   │
│   ├── providers/                     # 状态管理层
│   │   ├── medicine_provider.dart     # 药品状态管理
│   │   └── settings_provider.dart     # 设置状态管理
│   │
│   ├── screens/                       # 页面层
│   │   ├── home_screen.dart           # 首页
│   │   ├── photo_entry_screen.dart    # 拍照录入页
│   │   ├── medicine_detail_screen.dart # 药品详情页
│   │   ├── search_result_screen.dart  # 搜索结果页
│   │   ├── profile_screen.dart        # 我的页面
│   │   ├── member_manage_screen.dart  # 家庭成员管理
│   │   └── settings_screen.dart       # 设置页面
│   │
│   └── widgets/                       # 组件层
│       ├── stat_card.dart             # 统计卡片
│       ├── medicine_card.dart         # 药品卡片
│       └── bottom_nav.dart            # 底部导航
│
├── android/                           # Android 平台代码
│   ├── app/
│   │   └── src/main/
│   │       └── AndroidManifest.xml    # Android 配置文件
│   └── ...
│
├── ios/                               # iOS 平台代码（可选）
│   └── ...
│
├── assets/                            # 资源文件
│   ├── images/                        # 图片资源
│   └── icons/                         # 图标资源
│
├── pubspec.yaml                       # 项目依赖配置
├── BUILD_APK.md                       # APK 构建指南
└── README.md                          # 项目说明
```

## 核心模块说明

### 1. 数据模型 (models/)
- **Medicine**: 药品实体，包含药品的所有信息
- **User**: 用户实体，家庭成员信息
- **MedicineImage**: 药品图片，支持多张图片

### 2. 数据库 (database/)
- **DatabaseHelper**: 数据库初始化和管理
- **MedicineDao**: 药品增删改查操作
- **UserDao**: 用户增删改查操作
- **MedicineImageDao**: 图片增删改查操作

### 3. 状态管理 (providers/)
- **MedicineProvider**: 药品数据状态管理
- **SettingsProvider**: 应用设置状态管理

### 4. 页面 (screens/)
- **HomeScreen**: 首页，展示统计和药品列表
- **PhotoEntryScreen**: 拍照录入流程
- **MedicineDetailScreen**: 药品详情和操作
- **SearchResultScreen**: 搜索结果展示
- **ProfileScreen**: 个人中心
- **MemberManageScreen**: 家庭成员管理
- **SettingsScreen**: 应用设置

### 5. 组件 (widgets/)
- **StatCard**: 统计卡片组件
- **MedicineCard**: 药品卡片组件
- **BottomNav**: 底部导航组件

## 技术栈

- **UI 框架**: Flutter 3.x
- **状态管理**: Provider
- **数据库**: SQLite (sqflite)
- **图片选择**: image_picker
- **相机**: camera
- **OCR**: Google ML Kit (需配置)
- **通知**: flutter_local_notifications
- **日期格式化**: intl
- **浏览器打开**: url_launcher

## 数据库设计

### medicines 表
- id: 主键
- name: 药品名称
- brand: 品牌
- category: 分类
- totalQuantity: 总量
- remainingQuantity: 剩余量
- price: 价格
- purchaseMethod: 购买方式
- purchaseChannel: 购买渠道
- purchaseAddress: 购买地址
- purchaseDate: 购买日期
- expiryDate: 有效期
- userId: 用户ID
- status: 状态
- remarks: 备注
- createdAt: 创建时间
- updatedAt: 更新时间

### users 表
- id: 主键
- name: 姓名
- role: 角色
- createdAt: 创建时间
- updatedAt: 更新时间

### medicine_images 表
- id: 主键
- medicineId: 药品ID（外键）
- imagePath: 图片路径
- type: 图片类型
- createdAt: 创建时间
