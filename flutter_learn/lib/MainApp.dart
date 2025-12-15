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
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,   
      home: Scaffold(
        appBar: AppBar(title: const Text(appTitle)),
        body: Column(
          children: [
            Container(
              color: Colors.red,
              width: 200,
              height: 100,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 200,
              height: 100,
              child: Container(
                color: Colors.red,
              ),
            ),
            Container(
              color: Colors.red,
              width: 200,
              height: 100,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Container(
                  color: Colors.blue,
                ),
              )
            ),
          ],
        )
      ),
      
    );
  }
}