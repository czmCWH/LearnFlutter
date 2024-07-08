/*
<https://api.flutter-io.cn/flutter/widgets/PageView-class.html>

---- 分页滚动布局

👉 1、PageView
PageView 是一页一页滚动的列表。PageView 的每个子级都必须与 viewport（视口）大小相同。

PageController 的作用：
  可控制哪个页面在视图中可见。
  可用于控制页面的偏移，即 viewport（视口）大小的增量。
  可用于控制 PageController.initialPage（确定首次构建 PageView 时显示哪个页面）和 PageController.viewportFraction（确定页面大小占视口大小的比例）。


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

    var children = <Widget>[];
    var colorArr = [Colors.green, Colors.orange, Colors.amber];
    for (int i = 0; i < colorArr.length; ++i) {
      children.add( _Page( text: '$i', color: colorArr[i],));
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView 分页滚动'),
      ),
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: PageController(initialPage: 2, viewportFraction: 0.8),    // 控制初次显示的页面，以及视口的大小
        physics: const BouncingScrollPhysics(),
        pageSnapping: false,    // 每次滑动是否强制切换整个页面，如果为false，则会根据实际的滑动距离显示页面
        onPageChanged: (int index) {
          debugPrint('索引 $index 发生了改变');
        },
        allowImplicitScrolling: false,
        children: children,
      ),
    );
  }
}


// Tab 页面 
class _Page extends StatefulWidget {
  const _Page({
    Key? key,
    required this.text,
    required this.color
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: double.infinity, minHeight: double.infinity),
      child: Container(
        color: widget.color, 
        child: Center(child: Text(widget.text),),
      ),
    );
  }
}
