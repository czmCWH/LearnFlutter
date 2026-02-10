import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/index.dart';
import 'detail.dart';
import '../user.dart';

/*
  1、Getx 路由跳转数据传递
    - Path 路径参数
    - Query 查询参数
    - parameters 任意类型参数

 */

class ScreenB extends StatefulWidget {
  const ScreenB({super.key});

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {

  final user = User(
    id: '123',
    name: '张三',
    email: 'zhangsan@example.com',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("B页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            // 👉 1、发送任意类型的数据到下一个页面，无论是一个字符串，一个Map，一个List，甚至一个类的实例。
            Text("发送复杂数据"),
            ElevatedButton(
              onPressed: () async {
                 var data = await Get.to(DetailScreen(), arguments: user);
                 debugPrint("--- 页面返回数据：${data.toString()}");
              }, 
              child: Text("普通导航传递参数")
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.detail, arguments: user);
              }, 
              child: Text("命名导航 - arguments 参数")
            ),

            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.detail, parameters: { "id": "12", "name": "abc"} );
              }, 
              child: Text("命名导航 - parameters 参数，即 URL参数")
            ),

            // 分割线
            const Divider(height: 1, thickness: 1),

            //  👉 2、命名路由传递数据
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.detail, arguments: user);
              }, 
              child: Text("命名导航-传递 Path 路径参数")
            ),

            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.detail, arguments: user);
              }, 
              child: Text("命名导航-传递 Query 查询参数")
            ),

            
          ],
        ),
      ),
    );
  }
}