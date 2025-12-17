/*
<https://docs.flutter.cn/ui/adaptive-responsive/safearea-mediaquery>
<https://api.flutter.dev/flutter/widgets/SafeArea-class.html>

---- 安全边距

👉 1、SafeArea
将使子级缩进足够多以避免屏幕顶部的状态栏。

👉 2、MediaQuery
MediaQuery.of 

MediaQuery.removePadding

 */

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: MySafeArea(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MySafeArea extends StatelessWidget {
  
  const MySafeArea({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(   // 添加 SafeArea 避免 Container 从状态栏下布局
        child: Container( 
          color: Colors.red,
          height: 200,
          child: Row(
            children: [ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<String>(builder: (BuildContext context) {
                  return const MyMediaQueryPage();
                }),  
              );
            }, 
            child: const Text('跳转'),
          ),],
          )
        ),

      ),
    );
  }
}

class MyMediaQueryPage extends StatelessWidget {
  const MyMediaQueryPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1、MediaQuery.of 获取屏幕的安全边距、宽、高
    double top = MediaQuery.of(context).padding.top;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    debugPrint('top = $top, width = $width, height = $height');

    return Scaffold(
      body: Column(
        children: [
          Container(height: top + 44, color: Colors.red,),
          Expanded(
            // 2、MediaQuery.removePadding 移除 ListView 自带状态栏下滑
            child: MediaQuery.removePadding(removeTop: true, context: context, child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  color: Colors.greenAccent,
                  height: 200,
                ),
                Container(
                  color: Colors.greenAccent,
                  height: 200,
                )
              ],
            ),)
          ),
        ],
      ),
    );
  }
}

