import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/*
  1、Flutter 通过 loadFlutterAsset 的方式加载h5：用于加载 Flutter 项目目录中的静态 HTML 文件。 
 */

class FlutterH5AssetJump extends StatefulWidget {
  const FlutterH5AssetJump({super.key});

  @override
  State<FlutterH5AssetJump> createState() => _FlutterH5AssetJump();
}

class _FlutterH5AssetJump extends State<FlutterH5AssetJump> {

  late WebViewController controller;

  get _loadBtn => FilledButton(
    onPressed: () {
      _onLoadFlutterAssets(context);
    }, 
    child: const Text('加载H5', style: TextStyle(color: Colors.white),)
  );
  
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通过 loadFlutterAsset 的方式加载 H5'),
        actions: [
          _loadBtn,
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }

  void _onLoadFlutterAssets(BuildContext context) async {
    // 加载项目 assets/hiH5/目录下的index.html文件
    await controller.loadFlutterAsset('assets/hiH5/index.html');
  }
}