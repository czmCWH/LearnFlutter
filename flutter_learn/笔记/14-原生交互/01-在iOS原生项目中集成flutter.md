# 在iOS原生项目中集成flutter

## 创建 Flutter module

[将 Flutter module 集成到 iOS 项目](https://flutter.cn/docs/development/add-to-app/ios/project-setup)

创建 `some/path/` 文件夹：

在终端执行如下命令：

```
cd some/path/
flutter create --template module my_flutter
```

`Flutter module` 会创建在 `some/path/my_flutter/` 目录，目录结构和普通 Flutter 应用类似：

```
my_flutter/
├── .ios/
│   ├── Runner.xcworkspace
│   └── Flutter/podhelper.rb
├── lib/
│   └── main.dart
├── test/
└── pubspec.yaml
```

## 在现有iOS项目中集成 Flutter module

如下 通过 `CocoaPods` 来集成

1、先把iOS项目移动到 `some/path/` 下，目录结构如下：

```
some/path/
├── my_flutter/
│   └── .ios/
│       └── Flutter/
│         └── podhelper.rb
└── MyApp/
    └── Podfile
```


2、修改 `podfile` 文件如下，然后 `pod install` 即可。

```shell
platform :ios, '9.0'

flutter_application_path = '../my_flutter'   # 这个路径是 Flutter module 目录
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'MyApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!


  pod 'SnapKit'
  
  install_all_flutter_pods(flutter_application_path)			# 按照Flutter模型
  
  # 增加了原生 Apple Silicon arm64 iOS 模拟器的支持。
  post_install do |installer|
    flutter_post_install(installer) if defined?(flutter_post_install)
  end
end
```

## 在 iOS 原生页面中添加 flutter 页面

[在 iOS 应用中添加 Flutter 页面](https://flutter.cn/docs/development/add-to-app/ios/add-flutter-screen?tab=no-engine-vc-swift-tab)

设置初始路由无效 setInitialRoute ：https://fullstackaction.com/pages/4b18ae/#%E4%B8%80%E3%80%81%E5%88%9B%E5%BB%BAflutter%E6%A8%A1%E5%9D%97
```dart

```

https://docs.flutter.dev/development/add-to-app/ios/add-flutter-screen?tab=initial-route-swift-tab#using-the-flutterappdelegate


## 参考博客

[android/ ios,在Android和iOS中集成flutter](https://blog.csdn.net/weixin_33752006/article/details/117655818)

[iOS原有项目集成flutter](https://www.cnblogs.com/lovemargin/p/15003121.html)

