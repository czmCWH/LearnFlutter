/*
<https://docs.flutter.cn/cookbook/persistence/reading-writing-files>
<https://api.flutter-io.cn/flutter/dart-io/dart-io-library.html>
<https://pub-web.flutter-io.cn/packages/path_provider>

--- 文件读写

👉 1、文件处理
为了将文件保存到磁盘，你需要结合使用 dart:io 和 path_provider 这个 package。

path_provider package 
  提供一种平台无关的方式以一致的方式访问设备的文件位置系统；
  使用：
    flutter pub add path_provider

    import 'package:path_provider/path_provider.dart';


dart:io package 
  是系统提供的 package，用于引用文件，对文件进行读写操作。


 */

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: MyPathFile(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

// 创建状态
class MyPathFile extends StatefulWidget {

  MyPathFile({ Key? key }) : super(key: key);

  final CounterStorage storage = CounterStorage();

  @override
  State<MyPathFile> createState() {
    return _MyPathFile();
  }
}

class _MyPathFile extends State<MyPathFile> {
  
 int _counter = 0;

  @override
  void initState() {
    super.initState();
    // 读取数据
    widget.storage.readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _incrementCounter() {
    setState(() {
      _counter++;
    });

    // 把变量存储到文件
    return widget.storage.writeCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件读写'),
      ),
      body: Center(
        child: Text(
          '按钮点击 $_counter 次.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '增加',
        child: const Icon(Icons.add),
      ),
    );
  }

}

class CounterStorage {

  // 获取临时（缓存）文件夹，系统可以随时清空。
  Future<String> get _tmpPath async {
    final Directory tempDir = await getTemporaryDirectory();

    return tempDir.path;
  }

  Future<String> get _localPath async {
    // 获取 Documents 目录，只有在删除应用时，系统才会清除这个目录。
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;

      // 读取文件
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      // 获取数据失败
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // 写入数据
    return file.writeAsString('$counter');
  }
}
