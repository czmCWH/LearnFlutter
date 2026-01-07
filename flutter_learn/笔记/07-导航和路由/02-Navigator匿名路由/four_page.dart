import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FourPage extends StatefulWidget {
  const FourPage({super.key});

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {

  @override
  Widget build(BuildContext context) {

    // 获取带有参数的当前路由 Route
    final todo = ModalRoute.of(context)!.settings.arguments as Todo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FourPage页'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: _onPop,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("title 参数：${todo.title}"),
            Text("description 参数：${todo.description}"),
          ],
        ),
      ),
    );
  }

  void _onPop() {
    Navigator.pop(context);
  }
}


class Todo {
  final String title;
  final String description;

  const Todo(this.title, this.description);
}