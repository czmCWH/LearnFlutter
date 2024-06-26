import 'package:flutter/material.dart';


class MyStatelessScaffold extends StatelessWidget {
  
  const MyStatelessScaffold({super.key, this.tipStr});

  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Center(
        child: Text(
          tipStr ?? '默认显示，好好学习',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
