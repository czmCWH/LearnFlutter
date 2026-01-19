import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/index.dart';

class AThreeScreen extends StatefulWidget {
  const AThreeScreen({super.key});

  @override
  State<AThreeScreen> createState() => _AThreeScreenState();
}

class _AThreeScreenState extends State<AThreeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("A-Three-页面"),),
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("A-Three-页面"),
            ElevatedButton(
              onPressed: () { 

                 Get.until((route) => route.isFirst);
              }, 
              child: Text("返回到根路由")
            ),
          ],
        ),
      ),
    );
  }
}