import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/index.dart';

class AFourScreen extends StatefulWidget {
  const AFourScreen({super.key});

  @override
  State<AFourScreen> createState() => _AFourScreenState();
}

class _AFourScreenState extends State<AFourScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("A-Four-页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("A-Four-页面"),
            ElevatedButton(
              onPressed: () { 
                
                Get.until((route) => Get.currentRoute == Routes.root);

                // Get.until((route) => route.isFirst);
              }, 
              child: Text("返回到根路由")
            ),
          ],
        ),
      ),
    );
  }
}