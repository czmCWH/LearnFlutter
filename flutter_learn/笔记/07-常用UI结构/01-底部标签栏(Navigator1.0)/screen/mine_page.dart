import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的"),),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("我的"),
        ],
      ),
    );
  }
}