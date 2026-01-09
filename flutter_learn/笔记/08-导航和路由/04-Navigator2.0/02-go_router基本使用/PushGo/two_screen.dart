import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TwoScreen extends StatefulWidget {
  const TwoScreen({super.key});

  @override
  State<TwoScreen> createState() => _TwoScreenState();
}

class _TwoScreenState extends State<TwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Two页"),),
      backgroundColor: Colors.blue[200],
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

            ElevatedButton(
              onPressed: () {
                // 基于 Navigator.pop 返回到第一个路由（即根路由）
                Navigator.of(context).popUntil((route) => route.isFirst);

                // 基于 Navigator.pop 返回到指定条件的路由
                // Navigator.of(context).popUntil(
                //   ModalRoute.withName('/home'), // 需要 route settings.name 匹配
                // );
              }, 
              child: Text("返回到首页 - 基于 Navigator"),
            ),

            ElevatedButton(
              onPressed: () {
                context.go("/");
              }, 
              child: Text("返回到首页 - go(/)方式"),
            ),
            
            
          ],
        ),
      ),
    );
  }
}