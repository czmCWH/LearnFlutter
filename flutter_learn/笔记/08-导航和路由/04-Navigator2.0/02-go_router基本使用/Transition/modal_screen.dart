import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModalScreen extends StatefulWidget {
  const ModalScreen({super.key});

  @override
  State<ModalScreen> createState() => _ModalScreenState();
}

class _ModalScreenState extends State<ModalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("模态显示"),),
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("模态显示页面"),
            ElevatedButton(
              onPressed: () {
                context.pop();
              }, 
              child: Text("关闭页面")
            ),
          ],
        ),
      ),
    );
  }
}