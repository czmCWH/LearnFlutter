import 'package:flutter/material.dart';

class OnePage extends StatefulWidget {

  // 接收其它页面参数
  final String? param;

  const OnePage({super.key, this.param});

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnePage页'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: _onPop,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("上一页参数：${widget.param}"),
            ElevatedButton(
              onPressed: _onPop,
              child: const Text('点击返回并传参'),
            ),
          ],
        ),
      ),
    );
  }

  void _onPop() {
     Navigator.pop(context, "我是 one page !");
  }
}