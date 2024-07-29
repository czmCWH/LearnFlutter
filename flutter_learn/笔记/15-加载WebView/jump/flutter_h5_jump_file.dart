import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:path_provider/path_provider.dart';

const String h5String = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Flutter 通过 loadFlutterAsset 的方式跳转到 h5</title>
</head>
<body>
  <div id="txt" style="font-size: 1em;">从 asset file 中加载 h5</div>
</body>
</html>
''';

/// 通过 loadFile 的方式加载 H5
class FlutterH5JumpFile extends StatefulWidget {
  const FlutterH5JumpFile({super.key});

  @override
  State<FlutterH5JumpFile> createState() => _FlutterH5JumpFileState();
}

class _FlutterH5JumpFileState extends State<FlutterH5JumpFile> {

  late WebViewController controller;

  get _loadBtn => FilledButton(
    onPressed: () => _onLoadLoacalFileExample(context), 
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
        title: const Text('通过 loadFile 的方式加载 H5'),
        actions: [
          _loadBtn,
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }

  _onLoadLoacalFileExample(BuildContext context) async {
    // 把 h5 字符串保存到本地文件中，然后再加载
    final String path = await _prepareFile();
    debugPrint('---加载的path = $path');
    // 加载本地目录下的 h5 文件
    await controller.loadFile(path);
  }

  _prepareFile() async {
    final tmpDir = (await getTemporaryDirectory()).path;
    // 1、创建文件
    final File file = File(<String>{tmpDir, 'hiH5', 'index.html'}.join(Platform.pathSeparator));
    await file.create(recursive: true);
    // 2、向文件中写入 h5 数据
    await file.writeAsString(h5String);
    return file.path;
  }

}