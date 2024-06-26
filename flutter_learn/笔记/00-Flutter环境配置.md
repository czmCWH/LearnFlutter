# Flutter 环境配置

## 一、Flutter 安装

1、从 [Flutter SDK 发行页](https://flutter.io/sdk-archive/#macos) 下载SDK

2、将下载下来的压缩文件解压到指定的位置，如下：

```
$ cd ~/Applications
$ unzip ~/Desktop/flutter_macos_1.22.5-stable.zip
```

3、将 Flutter 添加到 PATH 中需要配置环境变量：

关于软件包的临时镜像路径，请参考[在中国使用Flutter](https://flutter.dev/community/china)

### Flutter 渠道切换

Flutter 有四个发布渠道：`stable`(稳定版), `beta`(测试版), `dev`(开发者), 和 `master`(主干)。

```
// 查看当前 Flutter 通道
$ flutter channel

// 切换至 dev 
$ flutter channel dev
```

### 更新 Flutter

```
// 更新 当前 Flutter 通道上可用的、最新版本的Flutter SDK
$ flutter upgrade 

// 把 Flutter 更新到指定的版本号
$ flutter upgrade v2.2.3
```

### 升级 packages

如果你修改了 `pubspec.yaml` 文件，或者只想更新应用程序依赖的 `packages`（而不是 `packages` 和 `Flutter` 本身），请使用 `flutter pub` 命令之一。

要更新到 `pubspec.yaml` 文件中列出的所有依赖项的最新兼容版本，请使用upgrade命令：

```
$ flutter pub upgrade
```

要标识过时的 package 依赖关系并获取有关如何更新它们的建议，请使用过时的命令。 有关详细信息，请参见[Dart发布过时的文档](https://dart.dev/tools/pub/cmd/pub-outdated)。

```
$ flutter pub outdated
```

## 二、Flutter 常用的终端命令

```
// 查看 Flutter 安装到的目录
$ which flutter

// 检查 macOS 完整的 Flutter 开发环境的所有组件
$ flutter doctor
// flutter doctor 返回错误时，使用此命令获取错误详细信息 
$ flutter doctor -v

// 查看flutter版本号
$ flutter --version

// 终端运行 flutter 项目，注意：运行前必须先启动一个模拟器
$ open -a Simulator
$ flutter run

// 清理缓存
$ flutter clean
```

## 三、调试 Flutter 项目常用快捷键

快捷键
* r 键：点击后热加载，也就算是重新加载吧。
* R 键：热重启。
* p 键：显示网格，这个可以很好的掌握布局情况，工作中很有用。
* c 键：清理屏幕
* o 键：切换android和ios的预览模式。
* q 键：终止 App 运行。
* d 键：分离，终止 `flutter run`，保持 App 运行。
* h 键：列出所有可用的交互命令。


## 四、格式化 Flutter 代码

<https://doc.flutterchina.club/formatting/#自动格式化VS Code中的代码>

* 在 VS Code 中【右键】> 【格式化代码】