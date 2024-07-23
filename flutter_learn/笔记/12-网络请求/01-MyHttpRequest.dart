/*
<https://docs.flutter.cn/data-and-backend/networking>
http package：<https://pub-web.flutter-io.cn/packages/http>
HttpHeaders：<https://api.dart.cn/stable/3.4.4/dart-io/HttpHeaders-class.html>
JSON 字符串转Dart模型：<https://www.geekailab.com/io/tools/json-to-dart/>

---- 网络请求

👉 1、http package
http package 提供了获取网络数据最简单的方法。

> http package 支持 Android、iOS、macOS、Windows、Linux 以及 Web。
> 避免直接使用 dart:io 或 dart:html 来进行 HTTP 请求。这些库依赖于平台并绑定单个实现。
> 更多的 请求方式，可查阅 http package 官方文档。

使用：
    flutter pub add http
    import 'package:http/http.dart' as http;

👉 2、post 请求传递数据的2种方式
  * x-www-form-urlencoded
    也称为 form类型，是 http package 的默认内容类型。
    body必须为Map<String, String>类型。

  *  application/json; charset=UTF-8
    body为json字符串，通过 dart:convert 中的 jsonEncode() 来转换。

 */

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHttpRequest(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyHttpRequest extends StatefulWidget {

  const MyHttpRequest({ Key? key }) : super(key: key);

  @override
  State<MyHttpRequest> createState() {
    return _MyHttpRequest();
  }
}

class _MyHttpRequest extends State<MyHttpRequest> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('http package 请求网络数据'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: doGet, child: const Text('Get请求')),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: doPostDefault, child: const Text('Post请求, form表单提交')),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: doPostJSON, child: const Text('Post请求, json字符串方式提交')),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: doPut, child: const Text('Put请求, 更新数据')),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: doDelete, child: const Text('Delete请求, 删除数据')),
            const SizedBox(height: 20,),
          ],
        ),
      )
    );
  }

  // 1、发送 get 请求
  void doGet() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      headers: {
        // 可以使用 dart:io 来使用一些常见的 HttpHeaders
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
      },
    );
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('---- 请求成功 = $responseJson');
    } else {

    }
  }

  // 2、发送 post 请求，默认 form 表单方式提交数据
  void doPostDefault() async {
    var response = await http.post(
      Uri.parse('https://api.geekailab.com/uapi/test/test'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',   // 默认为此 form 格式提交
      },
      body: <String, String>{   // body 数据格式必须为Map<String, String>
        "requestPrams": "doPost",
      },
    ); 
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('--- post1 = $responseJson');
    } else {
    
    }
  }

  // 3、发送 post 请求，
  void doPostJSON() async {
    var params = {"requestPrams": "doPost"};
    var response = await http.post(
      Uri.parse('https://api.geekailab.com/uapi/test/testJson'), 
      headers: { 
        "content-type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(params), // 将数据转成 json 字符串
    ); 
    if (response.statusCode == 200) { 
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('--- post2 = $responseJson');
    } else { 
      
    }
  }

  // 4、put 请求更新数据
  void doPut() async {
    var response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': '更新了数据',
      }),
    );
    if (response.statusCode == 200) { 
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('--- put = $responseJson');
    } else { 
      
    }
  }

  // 5、delete 请求删除数据
  void doDelete() async {
    var id = 1;
    final http.Response response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) { 
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      debugPrint('--- delete = $responseJson');
    } else { 
      
    }
  }

}


