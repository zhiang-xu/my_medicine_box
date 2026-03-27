# GitHub Actions APK 构建指南

## 当前状态

✅ 代码已推送到 GitHub
✅ GitHub Actions 配置文件已创建

## 下一步操作

### 1. 等待自动构建

代码推送后，GitHub Actions 会自动触发构建：

1. 访问：https://github.com/zhiang-xu/my_medicine_box/actions
2. 等待几分钟后，你会看到新的 workflow 运行
3. 构建完成后，点击进入查看详情

### 2. 下载 APK

构建成功后：

1. 在 Actions 页面，找到最新的运行记录
2. 滚动到底部的 "Artifacts" 部分
3. 下载 `app-debug.apk`

### 3. 安装到手机

将 APK 传输到 Android 手机并安装即可。

## 预期构建时间

- 首次构建：约 5-10 分钟
- 后续构建：约 3-5 分钟

## 查看构建状态

实时查看：https://github.com/zhiang-xu/my_medicine_box/actions
