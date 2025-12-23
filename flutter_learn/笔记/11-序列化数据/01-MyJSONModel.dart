/*
JSON 和序列化数据，<https://docs.flutter.cn/data-and-backend/serialization/json>
JSON 字符串转Dart模型：<https://www.geekailab.com/io/tools/json-to-dart/>

👉 1、JSON 基本概念
  - 编码、序列化数据，是指将数据结构转换为字符串。
  - 解码、反序列化数据，是指将字符串转换为数据结构。

序列化数据 通常也指代将数据结构转换为更加易读的数据格式的整个过程。

Flutter 中的两种常规的 JSON 使用策略：
  1、手动序列化数据；
    - 即使用 Flutter 内置库 dart:convert。
    - 适用于较小的项目。
    - 弊端：如果存在笔误去获取一个不存在的 JSON 字段，则代码会在运行时抛出一个错误。
  
  2、利用代码生成进行自动序列化数据；
    - 利用代码生成的 JSON 序列化数据，意味着可以通过外部的库生成编码模板。
    - 例如：
        json_serializable package：能够通过注解让你的普通类序列化。<https://www.bilibili.com/read/cv9349362>
        built_value package：提供了更高层次的方法，让定义为无变化的类也能够被序列化为 JSON。
    - 适用于中大型项目。
    - 弊端：它需要一些初始化设置。并且，生成的源文件可能在你的项目导航中产生一些视觉上的混乱。

    json_serializable package，<https://pub-web.flutter-io.cn/packages/json_serializable/install>

 */

import 'package:flutter/material.dart';
import 'dart:convert';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyJSONModel(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyJSONModel extends StatefulWidget {

  const MyJSONModel({ Key? key }) : super(key: key);

  @override
  State<MyJSONModel> createState() {
    return _MyJSONModel();
  }
}

class _MyJSONModel extends State<MyJSONModel> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              var jsonStr = '{"name": "章三", "email": "zhangsan@12306.com"}';

              final userMap = jsonDecode(jsonStr) as Map<String, dynamic>;
              var objU = User.fromJson(userMap);
              debugPrint('---对json进行解码: ${objU.toString()}');

              String json = jsonEncode(objU);
              debugPrint('---对模型编码: $json');

            }, 
            child: const Text('解码、编码'),
          ),
        ],
      )
    );
  }


}


class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };

  @override
  String toString() {
    return 'name = $name, email = $email';
  }
}