import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../user.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail 页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Text("detail - 页面"),
            ElevatedButton(
              onPressed: () {
                final user = Get.arguments as User?;
                debugPrint("--- 参数为：user = $user");
              }, 
              child: Text("获取上一页面传递参数 - arguments")
            ),
            ElevatedButton(
              onPressed: () {
                final param = Get.parameters;
                debugPrint("--- param = $param");
              }, 
              child: Text("获取上一页面传递参数 - parameters (URL参数)")
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(result: {"msg": "返回数据", "code": 0});
              }, 
              child: Text("pop返回传递参数")
            ),

          ],
        ),
      ),
    );
  }
}