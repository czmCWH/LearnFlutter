/*
<https://api.flutter-io.cn/flutter/widgets/FutureBuilder-class.html>

---- 处理网络数据的 Widget

👉 1、FutureBuilder 
FutureBuilder是一个将异步操作和异步UI更新结合在一起的类，通过它我们可以将网络请求，数据库读取等的结果更新的页
面上。

AsyncSnapshot<T>.connectionState 属性的状态有：
    none:当前未连接到任何异步计算;
    waiting:连接到异步计算并等待交互;
    active:表示异步计算还在进行中;
    done:表示异步计算完成;
AsyncSnapshot<T>.data：异步计算接收的最新数据;
AsyncSnapshot<T>.error：异步计算接收的最新错误对象;


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
      home: MyFutureBuilder(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyFutureBuilder extends StatefulWidget {

  const MyFutureBuilder({ Key? key }) : super(key: key);

  @override
  State<MyFutureBuilder> createState() {
    return _MyFutureBuilder();
  }
}

class _MyFutureBuilder extends State<MyFutureBuilder> {

 late Future<DataModel> futureModel;

  @override
  void initState() {
    super.initState();
    // 如果你将 getData() 方法放在 build() 内，该方法会在每次重建应用时重复调用，同时还会拖慢应用程序的速度。
    // 将 getData() 的结果存储在状态变量中，可确保 Future 只执行一次，然后缓存(得到的数据)以备后续重新构建应用
    futureModel = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureBuilder 根据data构建 Widget'),
      ),
      body: Center(
        child: FutureBuilder<DataModel>(
          future: futureModel,
          builder: (BuildContext context, AsyncSnapshot<DataModel> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.toString());
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // 显示loading
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<DataModel> getData() async {

    var uri = Uri.parse("https://api.geekailab.com/uapi/test/test?requestPrams=11"); 
    final response = await http.get(uri);
    Utf8Decoder utf8decoder = const Utf8Decoder(); //fix 中文乱码
    var result = json.decode(utf8decoder.convert(response.bodyBytes)) as Map<String, dynamic>;
    debugPrint('--- result = ${result['data']}');
    if (response.statusCode == 200) {
      return DataModel.fromJson(result['data']);
    } else {
      throw Exception('加载数据失败');
    }
  }

}


class DataModel {
  final int code;
  final int requestPrams;
  final String method;

  const DataModel({
    required this.code,
    required this.requestPrams,
    required this.method,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    debugPrint('--- ${json['code'].runtimeType}、${json['requestPrams'].runtimeType}、${json['method'].runtimeType}');
    return DataModel(
      code: json['code'] as int, 
      requestPrams: int.parse(json['requestPrams']), 
      method: json['method'] ?? 'xxx'
    );
  }

  @override
  String toString() {
    return 'code = $code, requestPrams = $requestPrams, method = $method';
  }
}