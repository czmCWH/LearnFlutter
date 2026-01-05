import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


/// 👉 1、Flutter 通过 URL 向 H5 传递数据


class Flutter2jsByUrl extends StatefulWidget {
  const Flutter2jsByUrl({super.key});

  @override
  State<Flutter2jsByUrl> createState() => _Flutter2jsByUrlState();
}

class _Flutter2jsByUrlState extends State<Flutter2jsByUrl> {
  int progress = 0;
  late WebViewController controller;

  get _loadBtn => FilledButton(
    onPressed: () {
      // 通过 URL 向 h5 传递数据
      String urlStr = 'https://www.geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=Flutter的参数';
      controller.loadRequest(Uri.parse(urlStr));
    }, 
    child: const Text('加载H5', style: TextStyle(color: Colors.white),)
  );

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)  // 开启可JS执行
    ..setNavigationDelegate(NavigationDelegate(
      onPageFinished: (finshsed) {
        // WebViewWidget在onPageFinished方法中执行js方法失败
        debugPrint('-----网页加载完毕 = ${finshsed}');
        var name = 'Flutter 的参数';
        // 此处执行 js 方法报错
        try {
          controller.runJavaScript("hiCallJs('$name')");
        } catch (e) {
          debugPrint('----e =');
        } 
      },
      onProgress: (progress) {
      setState(() {
        this.progress = progress;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 通过 URL 向 H5 传递数据'),
        actions: [
          _loadBtn,
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Positioned(
            left: 100,
            bottom: 100,
            child: Text('加载进度: $progress'),
          ),
        ],
      ),
    );
  }
}