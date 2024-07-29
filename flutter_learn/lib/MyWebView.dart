/*
为你的 Flutter 应用添加 WebView：<https://docs.flutter.cn/codelabs>
webview_flutter插件下载：<https://pub.dev/packages/webview_flutter>
将 WebView 添加到您的 Flutter 应用：<https://codelabs.developers.google.com/codelabs/flutter-webview?hl=zh-cn#00



 */

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {

  const MyWebView({ Key? key }) : super(key: key);

  @override
  State<MyWebView> createState() {
    return _MyWebView();
  }
}

class _MyWebView extends State<MyWebView> {
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WebViewWidget(
          controller: 
        controller
        ),
      )
    );
  }

}
