import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyCustomDialog extends StatelessWidget {
  const MyCustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center( // 居中显示
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 自适应内容高度
            children: [
              const Text("提示", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              const Text("这是一个通过 go_router 实现的路由级弹窗。"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => context.pop(), // 关闭弹窗
                child: const Text("我知道了"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}