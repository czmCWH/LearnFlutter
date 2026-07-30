import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/index.dart';

class AOneScreen extends StatefulWidget {
  const AOneScreen({super.key});

  @override
  State<AOneScreen> createState() => _AOneScreenState();
}

class _AOneScreenState extends State<AOneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("A-One-页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("A-One-页面"),
            ElevatedButton(
              onPressed: () { 
                Get.toNamed(Routes.four);
              }, 
              child: Text("跳转到 four")
            ),
            ElevatedButton(
              onPressed: () { 
                Get.back();
              }, 
              child: Text("pop 返回")
            ),
          ],
        ),
      ),
    );
  }
}