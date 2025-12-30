# 一、查看Flutter版本
Flutter SDK 列表 <https://docs.flutter.cn/install/archive>，里面列出了 Flutter 版本 与 Dart 版本对应关系。
Flutter 最新版本介绍 <https://docs.flutter.cn/release/whats-new>、<https://docs.flutter.dev/release/whats-new>


# 二、安装 Flutter

1、从 [Flutter SDK 发行页](https://flutter.io/sdk-archive/#macos) 下载SDK

2、将 Flutter 包解压到指定的英文目录（如果在中文目录可能会报错），如下：

```shell
$ cd /Library
$ unzip ~/Desktop/flutter_macos_1.22.5-stable.zip
```

3、将 Flutter 添加到 PATH 中需要配置环境变量：
```shell
# 1、检查mac环境变量的配置文件（如果为 /bin/zsh 则配置文件为 ~/.zshrc；如果为 /bin/bash 则配置文件为  ~/.bash_profile）
$ echo $SHELL
/bin/zsh

# 2、终端编辑配置文件进行配置（也可以用文本编辑器打配置文件进行添加配置）
$ vi ~/.zshrc

# 3、配置如下环境变量（来自：https://docs.flutter.cn/community/china）
# Flutter 配置
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
export PATH="/Library/flutter/bin:$PATH"    # 格式为 ==> "Flutter包的存放目录（非中文目录）/flutter/bin:$PATH"

# 4、让配置文件生效
$ source ~/.zshrc

# 5、检查 Flutter 是否安装成功
$ flutter --version
```


# 三、更新 Flutter
<https://docs.flutter.cn/release/upgrade>

## Flutter 渠道

Flutter 有四个发布渠道：
* `stable`(稳定版), 适用于生产环境。
* `beta`(测试版), 每个月都会选取上个月的最佳开发版本，然后合并到beta版本进行推广测试。
* `master`(主干)，仓库的最新代码分支，供贡献者使用。

```shell
# 查看当前 Flutter 通道
$ flutter channel

# 切换至 dev 
$ flutter channel dev
```
## 更新 Flutter

```shell
# 更新 当前 Flutter 通道上可用的、最新版本的Flutter SDK、Dart
$ flutter upgrade 

# 把 Flutter 更新到指定的版本号
$ flutter upgrade v2.2.3
```