# 修复 Java RuntimeException

## 🔍 问题诊断

### 首先检查 Java 版本

```bash
java -version
```

**Flutter 要求的 Java 版本：**
- Flutter 3.x: 需要 JDK 11 或 JDK 17
- 推荐使用 JDK 11 (LTS)

### 检查 JAVA_HOME 环境变量

```bash
echo %JAVA_HOME%
```

## 🛠️ 解决方案

### 方案 1：检查并更新 Java 版本（推荐）

#### 步骤 1：下载正确版本的 JDK

**推荐使用 JDK 11：**

- **Oracle JDK 11 (LTS)**: https://www.oracle.com/java/technologies/javase/jdk11-archive-downloads.html
- **OpenJDK 11**: https://adoptium.net/temurin/releases/?version=11
- **Amazon Corretto 11**: https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/downloads-list.html

#### 步骤 2：安装 JDK

下载后，安装到：
- `C:\Program Files\Java\jdk-11`
- 或 `C:\Java\jdk-11`

#### 步骤 3：配置环境变量

1. **设置 JAVA_HOME**

   - 右键"此电脑" → 属性 → 高级系统设置
   - 点击"环境变量"
   - 在"系统变量"中点击"新建"
   - 变量名：`JAVA_HOME`
   - 变量值：`C:\Program Files\Java\jdk-11`（根据你的实际路径）
   - 点击确定

2. **更新 PATH**

   - 找到 `Path` 变量，点击"编辑"
   - 在最前面添加：`%JAVA_HOME%\bin;`
   - 点击确定保存

3. **重启命令行窗口**

   关闭所有命令行窗口，重新打开。

4. **验证安装**

   ```bash
   java -version
   echo %JAVA_HOME%
   ```

   应该显示：
   ```
   java version "11.0.xx" 20xx-xx-xx LTS
   C:\Program Files\Java\jdk-11
   ```

### 方案 2：增加 JVM 内存

#### 编辑 `android/gradle.properties`

确保配置如下：

```properties
org.gradle.jvmargs=-Xmx4G -XX:MaxMetaspaceSize=1G -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
```

#### 如果仍然内存不足，增加到 6G：

```properties
org.gradle.jvmargs=-Xmx6G -XX:MaxMetaspaceSize=2G -XX:+HeapDumpOnOutOfMemoryError -Dfile.encoding=UTF-8
```

### 方案 3：使用 Android Studio 内置的 JDK

如果你安装了 Android Studio：

1. 找到 Android Studio 内置的 JDK：
   - 通常在：`C:\Program Files\Android\Android Studio\jbr`
   - 或：`C:\Users\你的用户名\AppData\Local\Android\Sdk\build-tools\33.0.0\`

2. 设置 JAVA_HOME 指向这个路径

### 方案 4：使用 Gradle 包装器指定的 JDK

编辑 `android/gradle.properties`，添加：

```properties
org.gradle.java.home=C:\\Program Files\\Java\\jdk-11
```

## 🧪 测试 Java 配置

### 测试 1：验证 Java 版本

```bash
java -version
```

**期望输出：**
```
java version "11.0.xx" 20xx-xx-xx LTS
Java(TM) SE Runtime Environment (build 11.0.xx+xx)
Java HotSpot(TM) 64-Bit Server VM (build 11.0.xx+xx, mixed mode)
```

### 测试 2：验证 JAVA_HOME

```bash
echo %JAVA_HOME%
```

应该显示 JDK 的安装路径。

### 测试 3：检查 Gradle

```bash
cd android
gradlew --version
cd ..
```

**期望输出：**
```
Gradle 8.0
------------------------------------------------------------
Gradle 8.0
------------------------------------------------------------

Build time:   2023-xx-xx xx:xx:xx UTC
Revision:     xxxxxxxxxx

Kotlin:       1.8.20
Groovy:       3.0.13
Ant:          Apache Ant(TM) version 1.10.11 compiled on July 10 2021
JVM:          11.0.xx (Vendor: Oracle Corporation, OS: Windows 10, arch: amd64)
```

注意最后一行的 JVM 版本应该是 11 或 17。

## 🚀 重新构建

配置好 Java 后，重新构建：

```bash
# 1. 清理
flutter clean

# 2. 重新安装依赖
flutter pub get

# 3. 构建
flutter build apk --release --verbose
```

## 📋 常见的 RuntimeException 原因

### 1. OutOfMemoryError

**症状：** `java.lang.OutOfMemoryError: Java heap space`

**解决方法：**
```properties
org.gradle.jvmargs=-Xmx6G -XX:MaxMetaspaceSize=2G
```

### 2. ClassCastException

**症状：** `java.lang.ClassCastException`

**解决方法：**
- 检查 Java 版本是否为 11 或 17
- 更新 Gradle 版本
- 清理 Gradle 缓存：`cd android && gradlew clean`

### 3. NoClassDefFoundError

**症状：** `java.lang.NoClassDefFoundError`

**解决方法：**
- 检查依赖是否正确
- 运行 `flutter pub get`
- 清理并重新构建

### 4. UnsupportedClassVersionError

**症状：** `java.lang.UnsupportedClassVersionError: xxx has been compiled by a more recent version`

**解决方法：**
- 这个错误表示 Java 版本过低
- 升级到 JDK 11 或 17

## 🔧 完整的故障排查脚本

```batch
@echo off
echo ====================================
echo Java 环境诊断工具
echo ====================================
echo.

echo [1] 检查 Java 版本...
java -version
if errorlevel 1 (
    echo ERROR: Java 未安装或未配置
    pause
    exit /b 1
)
echo.

echo [2] 检查 JAVA_HOME...
echo JAVA_HOME=%JAVA_HOME%
if "%JAVA_HOME%"=="" (
    echo WARNING: JAVA_HOME 未设置
    echo.
    echo 请设置环境变量 JAVA_HOME 指向 JDK 安装目录
)
echo.

echo [3] 检查 Java 路径...
where java
echo.

echo [4] 检查 Gradle...
cd android
gradlew --version
cd ..
echo.

echo [5] 检查 Flutter...
flutter --version
flutter doctor -v
echo.

echo ====================================
echo 诊断完成
echo ====================================
echo.
echo 如果发现问题，请根据提示修复
pause
```

将上述脚本保存为 `check_java.bat` 并运行。

## 💡 快速修复步骤

### 如果显示 Java 版本不是 11 或 17：

1. 下载 JDK 11：https://adoptium.net/temurin/releases/?version=11
2. 安装到 `C:\Program Files\Java\jdk-11`
3. 设置环境变量：
   - JAVA_HOME = `C:\Program Files\Java\jdk-11`
   - PATH 添加 `%JAVA_HOME%\bin`
4. 重启命令行窗口
5. 运行 `java -version` 确认

### 如果显示 OutOfMemoryError：

编辑 `android/gradle.properties`：
```properties
org.gradle.jvmargs=-Xmx6G -XX:MaxMetaspaceSize=2G
```

### 如果仍然报错：

运行完整诊断并获取详细日志：
```bash
flutter build apk --release --verbose 2>&1 | tee build_debug.log
```

将 `build_debug.log` 文件的内容发给我，我可以进一步分析。

## 📞 需要更多帮助？

请提供以下信息：

1. `java -version` 的完整输出
2. `echo %JAVA_HOME%` 的输出
3. `gradlew --version` 的输出
4. `flutter build apk --release` 的完整错误信息

---

**最后更新**: 2024-03-27
