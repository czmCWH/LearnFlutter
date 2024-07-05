/*
<https://api.flutter-io.cn/flutter/widgets/PageView-class.html>

---- 分页布局

👉 1、PageView
PageView 是一页一页滚动的列表。PageView 的每个子级都必须与 viewport（视口）大小相同。

PageController 可控制哪个页面在视图中可见。
PageController 可用于控制页面的偏移，即 viewport（视口）大小的增量。
PageController 可用于控制 PageController.initialPage（确定首次构建 PageView 时显示哪个页面）和 PageController.viewportFraction（确定页面大小占视口大小的比例）。


 */

import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  // 定义常量构造函数
  const MyPageView({ super.key });

  // 存储可变状态
  @override
  State<MyPageView> createState() {
    return _MyPageView();
  }
}

class _MyPageView extends State<MyPageView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 0.8),
            physics: const BouncingScrollPhysics(),
            pageSnapping: false,
            onPageChanged: (int index) {
              debugPrint('索引 $index 发生了改变');
            },
            allowImplicitScrolling: false,
            children: [
              Center(
                child: Container(
                  width: 200,
                    height: 300,
                    color: Colors.red,
                    child: const Text('111')
                ),
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 300,
                  color: Colors.green,
                  child: const Text('222')
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
