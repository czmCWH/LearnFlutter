# 一、Flutter 与 H5 通信

## 1、JS 向 Flutter 传递数据

  * 通过 URL 方式：
    在 H5 通过JS改变URL；
    WebView 处理URL并发起 URL 请求；
    Flutter 通过 navigationDelegate 解析URL数据并拦截 URL 跳转。
  
  * 通过 JavaScriptChannels 的方式
    Flutter 中创建 webViewController，并注册 JS channel；
    在 H5 中使用 JS channel 传递数据;


## 2、Flutter 向 JS 传递数据

  * 通过 URL 的方式
    在 Flutter 中 使用 WebViewController.loadRequest 加载URL，在URL后面传递数据；
    在 H5 中获取URL，并解析URL中的数据。

  * 通过 runJavascript 方式
    在 Flutter 中使用 webView 提供的 runJavascript API 执行 JS 代码；
    在 H5 中

# 二、Flutter 跳转到 H5 的几种方式
1、loadRequest 的方式：
    用于根据URL加载H5；特点：可以多次加载不同的URL

2、loadHtmlstring 的方式；
    用于加载 HTML 字符串；特点：如果要修改 HTML 中的内容，推荐此方式

3、loadFile 的方式;
    用于加载手机目录下的 HTML 文件；特点：可以加载H5离线包

4、loadFlutterAsset 的方式；
    用于加载 Flutter 项目目录中的HTML 文件；特点需要在 pubspec.yaml 文件中注册html文件目录，html文件会随项目一起打包。

# 三、Flutter 同步登录状态到h5防止二次登录
同步的几种方式：
1、通过 cookie 的方式：将登录后获取的 token、userId 等信息存储到 webView 的cookie 中；
2、通过桥接的方式：Flutter 提供一个供 H5 获取登录信息的 channel，h5通过这个channe来获取登录信息；

1.Flutter 提供一个供H5获取登录信息的channel，H5 通过这个 channel 来告诉 Flutter要获取登录信息;
2.然后 Flutter 调用 JS 的函数来将登录信息传递到 H5;


# 博客
为你的 Flutter 应用添加 WebView：<https://docs.flutter.cn/codelabs>
webview_flutter插件下载：<https://pub.dev/packages/webview_flutter>
将 WebView 添加到您的 Flutter 应用：<https://codelabs.developers.google.com/codelabs/flutter-webview?hl=zh-cn#00