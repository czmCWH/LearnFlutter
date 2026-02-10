import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/*
 1、go_router 实现页面转场
  go_router 是基于 Page 的，所以转场风格同样支持：
    MaterialPage
    CustomTransitionPage
  对于非路由弹窗（即 弹窗不需要支持 URL 导航或浏览器“后退”键），
  请使用 Flutter 原生的 showDialog() 或 showModalBottomSheet()，这样代码更简洁。
 */

class TransitionScreen extends StatefulWidget {
  const TransitionScreen({super.key});

  @override
  State<TransitionScreen> createState() => _TransitionScreenState();
}

class _TransitionScreenState extends State<TransitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("go_router 页面转场"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push("/modal");
              }, 
              child: Text("模态显示页面"),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/scale");
              }, 
              child: Text("自定义转场 - 炫酷的效果"),
            ),
            ElevatedButton(
              onPressed: () {
                context.push("/dialog");
              }, 
              child: Text("自定义转场 - 中间弹窗"),
            ),
            
          ],
        ),
      ),
    );
  }
}