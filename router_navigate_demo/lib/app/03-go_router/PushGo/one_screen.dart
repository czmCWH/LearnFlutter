import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
  1、go_router 插件页面跳转API
    - context.go('/path')，跳转（不保留历史，无法返回）
    - context.push('/path')，跳转（保留历史，可返回）
    - context.pop()，返回上一页
    - context.replace('/path')，替换当前页
    - GoRouter.of(context).uri.toString()，获取当前路由路径
 */

class OneScreen extends StatefulWidget {
  const OneScreen({super.key});

  @override
  State<OneScreen> createState() => _OneScreenState();
}

class _OneScreenState extends State<OneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("go_router 基本API"),),
      backgroundColor: Colors.red[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            ElevatedButton(
              onPressed: () {
                context.pop();
                // 或者
                // GoRouter.of(context).pop();
              }, 
              child: Text("返回 - GoRouter.pop"),
            ),
            
            // go 和 push 的区别
            ElevatedButton(
              onPressed: () {
                context.push("/two");
              }, 
              child: Text("GoRouter.push -> TwoPage")
            ),

            ElevatedButton(
              onPressed: () {
                context.go("/two");
              }, 
              child: const Text('GoRouter.go -> TwoPage'),
            ),
          ],
        ),
      ),
    );
  }
}