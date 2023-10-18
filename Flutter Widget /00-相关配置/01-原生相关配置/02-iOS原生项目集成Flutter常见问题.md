# iOS原生项目集成Flutter常见问题


## 1、`pod install` 报错
```
file: C:\src\flutter/bin/cache/artifacts/engine/ios-release must exist.
```

解决办法：

1、在终端 `cd` 到  `my_flutter`(`Flutter module`所在的目录) 执行如下命令：

```shell
$ flutter clean
$ flutter pub get
```

2、然后切换到 `MyApp` 项目目录

```shell
$ pod install
```

## 2、运行项目时，报错 App.framework 如下，App显示白屏：

```
dyld: Library not loaded: @rpath/App.framework/App
  Referenced from: /private/var/containers/Bundle/Application/7B0397C9-18B5-46D6-B548-32675FBEC469/MyApp.app/MyApp
  Reason: image not found
dyld: launch, loading dependent libraries

Failed to find assets path for "Frameworks/App.framework/flutter_assets"
```

这是因为 `Flutter` 的 `App.framework` 没有导入。


解决方案源自博客 [Flutter_Library not loaded: @rpath/App.framework/App](https://blog.csdn.net/FlyingKuiKui/article/details/123728932)：

> 1、打开 `Pods-xx-frameworks.sh`，然后添加以下代码：

```
install_framework "${PODS_ROOT}/../my_flutter/.ios/Flutter/App.framework"
```

> 2、配置 Xcode 运行环境，添加脚本：

`target -> Build Phases -> + -> New Run Script Phase -> Run Script`


### 3、iOS14 机型在 Debug 模式下手机链接数据线可以打开flutter页面，拔掉数据线不行。

关于这个问题 Flutter 官方文档上有介绍，[iOS debugging](https://docs.flutter.dev/development/platform-integration/ios/ios-debugging)

[关于iOS 14+系统调试模式下安装的App，断开调试模式后无法打开Flutter页面的问题说明](https://www.jianshu.com/p/6e9930c8118e) 博客中有解决办法，

* Debug模式下，Flutter也实现了热重载，默认编译方式为JIT

* 而iOS 14+系统对这种编译模式做了限制，导致无法启动

解决方式推荐使用， 更改Xcode编译模式：Xcode使用 Release 模式编译，这个时候Flutter编译方式为AOT，可正常启动。

其它解决办法：

1、找到 `Flutter SDK` 目录中搜索 `xcode_backend.dart` 文件，修改如下配置并保存。

参考博客：[Flutter混合项目在 iOS14+启动崩溃处理方法](https://www.jianshu.com/p/c7f90cac59fb)

在 `Flutter 2.8` 以前的老版本，需要修改 `xcode_backend.sh` 文件。

```dart

    if (buildMode != null) {
      if (buildMode.contains('release')) {
        return 'release';
      }
      if (buildMode.contains('profile')) {
        return 'profile';
      }
      if (buildMode.contains('debug')) {
        return 'debug';		// 此处改为 release
      }
    }
```

这样会导致项目跑的很慢，不过给测试打包足够了。



### 4、`Release` 模式运行时报错

```
Showing All Messages
'/Users/michael/Library/Developer/Xcode/DerivedData/MyApp-euwjbwrbomgnedfyrqfynatkoann/Build/Products/Release-iphoneos/App.framework/App' does not contain bitcode. You must rebuild it with bitcode enabled (Xcode setting ENABLE_BITCODE), obtain an updated library from the vendor, or disable bitcode for this target. file '/Users/michael/Library/Developer/Xcode/DerivedData/MyApp-euwjbwrbomgnedfyrqfynatkoann/Build/Products/Release-iphoneos/App.framework/App' for architecture arm64
```

解决方式一：

```
TARGETS --> Build Setings --> Build Options --> Enable Bitcode 设置为NO
```

解决方式二：

[flutter ios 打包出现的俩个问题](https://www.jianshu.com/p/43e6e8eed9a8)

博客作者先修改 `podfile` 文件如下：

```
post_install do |installer|
  installer.pods_project.targets.each do |target|
//    flutter_additional_ios_build_settings(target)     // ios 9.0时，此行代码需要注释掉。
    target.build_configurations.each do |config|
                     config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
                     config.build_settings['ENABLE_BITCODE'] = 'false'
                 end
  end
end
```

### 5、git管理 `Flutter module`所在的目录 时报错，文件太大无法提交

请注意检查 `.gitignore` 忽略文件，是否加入了：

```
build/
.android/
.ios/
.flutter-plugins
.flutter-plugins-dependencies
```

`.gitignore` 规则不生效的解决办法，先把本地缓存删除然后更新：

```
$ git rm -r --cached .

$ git add .

$ git commit -m 'update .gitignore'
```
