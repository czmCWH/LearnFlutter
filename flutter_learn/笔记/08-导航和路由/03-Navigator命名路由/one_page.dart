import 'package:flutter/Material.dart';

class OnePage extends StatefulWidget {

  const OnePage({super.key});

  @override
  State<OnePage> createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 接收路由参数
    // initState 中 获取不到路由参数，需在 Future.microtask 异步微任务中获取。
    Future.microtask(() {
      if (ModalRoute.of(context) != null) {
        final params = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
        debugPrint("--- 接收传递参数：${params.toString()}");
      } else {
         debugPrint("--- 没有获取到参数");
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    
    // 接收命名路由传递的参数
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;

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
            Text(
              '接收参数：\ntitle=${arguments?['title']}\nnumber=${arguments?['number']}',
              style: const TextStyle(fontSize: 18),
            ),
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