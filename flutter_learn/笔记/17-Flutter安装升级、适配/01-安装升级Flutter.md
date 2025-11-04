# 一、查看Flutter版本

Flutter SDK 列表 <https://docs.flutter.cn/release/archive>

Flutter 最新版本介绍 <https://docs.flutter.cn/release/whats-new>、<https://docs.flutter.dev/release/whats-new>

# 二、安装 Flutter

1、从 [Flutter SDK 发行页](https://flutter.io/sdk-archive/#macos) 下载SDK

2、将下载下来的压缩文件解压到指定的位置，如下：

```shell
$ cd ~/Applications
$ unzip ~/Desktop/flutter_macos_1.22.5-stable.zip
```

3、将 Flutter 添加到 PATH 中需要配置环境变量：

关于软件包的临时镜像路径，请参考[在中国使用Flutter](https://flutter.dev/community/china)

# 三、更新 Flutter
<https://docs.flutter.cn/release/upgrade>

## Flutter 渠道

Flutter 有四个发布渠道：
* `stable`(稳定版), 适用于生产环境。
* `beta`(测试版), 每个月都会选取上个月的最佳开发版本，然后合并到beta版本进行推广测试。
* `master`(主干)，仓库的最新代码分支，供贡献者使用。

```shell
// 查看当前 Flutter 通道
$ flutter channel

// 切换至 dev 
$ flutter channel dev
```
## 更新 Flutter

```shell
// 更新 当前 Flutter 通道上可用的、最新版本的Flutter SDK、Dart
$ flutter upgrade 

// 把 Flutter 更新到指定的版本号
$ flutter upgrade v2.2.3
```