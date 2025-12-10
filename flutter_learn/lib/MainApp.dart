import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    const String appTitle = 'Material 风格的 App';

    // 一个 Material App 从 MaterialApp 小部件开始
    return MaterialApp(
      // title：窗口标题，显示在浏览器上小字。
      title: appTitle,
      
      // theme：设置整个应用的主题，scaffoldBackgroundColor 主骨架的背景色。
      theme: ThemeData(scaffoldBackgroundColor: Colors.blue),

      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   

      // home：窗口展示的主体内容。
      home: Scaffold(

        // appBar，页面顶部导航栏
        appBar: AppBar(title: const Text(appTitle)),
        
        // backgroundColor，整个页面背景颜色
        backgroundColor: Colors.white,
        
        // body，整个页面的内容区域
        body: Container(
          child: const Center(
            child: Text('Hello World!'),
          ),
        ),

        // bottomNavigationBar，底部导航栏
        bottomNavigationBar: Container(
          height: 80,
          child: const Center(
            child: Text('底部区域'),
          ),
        ),
      ),
      
    );
  }
}