import 'package:flutter/material.dart';
import 'MyInheritedWidget.dart';
import 'widgets/index.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

   // 用户名
  String _userName = '默认：未登录';

  // 修改用户名
  void _changeUserName(String userName) {
    setState(() {
      _userName = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp 小部件开始
    return MaterialApp(
      title: "状态管理",  // title：窗口标题，显示在浏览器上小字。
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,   
      home: Scaffold(
        appBar: AppBar(
          title: const Text('基本组件'),
        ),
        // ⚠️ 使用 InheritedWidget 向其子 Widgets 提供公共的属性
        body: MyInheritedWidget(
          userName: _userName, 
          changeUserName: _changeUserName,  
          child: const SafeArea(
            child: Column(
              children: [
                // 头部
                HeaderWidget(),

                // 正文
                Expanded(child: UserView()),

                // 底部
                BottomWidget(),
              ],
            )
          )
        ),
      )
    );
  }
}









