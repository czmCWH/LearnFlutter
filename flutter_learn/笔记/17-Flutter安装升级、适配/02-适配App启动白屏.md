# 一、启动白屏
问题：通过 Flutter 开发的 App 在启动时都会出现1～3s的白屏现象。
原因：Flutter App 在启动的时候，会进行 SDK 的初始化，Flutter 会将代码读取到内存中，此时代码还没有完全渲染，这时屏幕没有内容展示。
解决：
    iOS端 使用 Xcode 打开 Flutter App，配置 LaunchScreen.storyboard。
    Android 端在 Flutter App 中添加 flutter_splash_screen <https://pub-web.flutter-io.cn/packages/flutter_splash_screen> 插件
