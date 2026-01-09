import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("首页 Navigator2.0 - go_router"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            
            ElevatedButton(
              onPressed: () {
                context.push("/one");
              }, 
              child: const Text(' 👉 1、页面跳转与返回'),
            ),

            ElevatedButton(
              onPressed: () {
                context.push("/value");
              }, 
              child: const Text(' 👉 2、页面跳转传参'),
            ),

            ElevatedButton(
              onPressed: () {
                context.push("/transition");
              }, 
              child: const Text(' 👉 3、页面转场效果'),
            ),
          ],
        ),
      ),
    );
  }
}