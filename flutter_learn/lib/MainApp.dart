import 'package:app_01/DioTool.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    const String appTitle = 'Material 风格的 App';

    // 一个 Material App 从 MaterialApp 小部件开始
    return MaterialApp(
      title: appTitle,  // title：窗口标题，显示在浏览器上小字。
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,   
      home: Scaffold(
        appBar: AppBar(
          title: const Text('基本组件'),
        ),
        body: const MyList(),
      ),
    );
  }
}

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              try {
                final res = await dioTool.get("/category");
                print("---res =");
                print(res);
              } catch (e) {
                final error = e as DioException;
                print(error.response);
              }
            }, 
            child: const Text("开始请求")
          ),
        ],
      ),
    );
  }
}
