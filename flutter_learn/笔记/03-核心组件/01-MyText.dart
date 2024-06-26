/*
Text widgets：https://docs.flutter.cn/ui/widgets/text
使用自定义字体： https://docs.flutter.cn/cookbook/design/fonts#set-styles-and-weights-with-font-files
TextStyle：https://api.flutter-io.cn/flutter/painting/TextStyle-class.html

FontWeight 字体权重 的约定俗称对应如下：
Thin	w100
Extra	w200
Light	w300
Normal/regular/plain	w400(默认)
Medium	w500
Semi-bold	w600
Bold	w700
Extra-bold-	w800
Black	900


2、Text.rich 构造函数
创建具有 InlineSpan 的文本 Widget。InlineSpan 的以下子类可用于构建富文本：
  > TextSpan 定义文本和子 InlineSpans。
  > WidgetSpan 定义嵌入式内联 Widget。

3、RichText
RichText 用于显示使用多种不同样式的文本。要显示的文本是使用 TextSpan 对象树描述的，每个对象都有一个用于该子树的关联样式。
RichText 中显示的文本【必须显式地】设置样式。在选择使用哪种样式时，请考虑使用 DefaultTextStyle。

RichText 没有 const 构造函数

 */

import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              "北冥有鱼，其名为鲲。鲲之大，不知其几千里也。化而为鸟，其名为鹏。鹏之背，不知其几千里也；怒而飞，其翼若垂天之云。是鸟也，海运则将徙于南冥。南冥者，天池也。",
              style: TextStyle(
                color: Colors.yellow, // 字体颜色
                backgroundColor: Colors.blue, // 文本背景色
                fontSize: 18, // 字体大小
                fontStyle: FontStyle.normal,    // 设置字体
                shadows: [  // 设置字体阴影
                  Shadow(color: Colors.red, offset: Offset(3, 5), blurRadius: 6)
                ],
                decoration: TextDecoration.overline, // 设置下划线
              ),
              textAlign: TextAlign.left, // 对齐方式
              overflow: TextOverflow.ellipsis, // 文本溢出时末尾样式 ellipsis：末尾点点显示
              maxLines: 3, // 最多显示行数
            ),
            const Text('字体 系统默认',),
            const Text('字体 PlaywriteMX-Regular', style: TextStyle(fontSize: 20, fontFamily: 'PlaywriteMX'),),
            const Text('字体 PlaywriteMX-Thin', style: TextStyle(fontSize: 20, fontFamily: 'PlaywriteMX', fontWeight: FontWeight.w100),),
            const Text('字体 PlaywriteMX-ExtraLight', style: TextStyle(fontSize: 20, fontFamily: 'PlaywriteMX', fontWeight: FontWeight.w200),),
            const Text('字体 PlaywriteMX-Light', style: TextStyle(fontSize: 20, fontFamily: 'PlaywriteMX', fontStyle: FontStyle.italic),),
            const Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 20),
                children: <InlineSpan>[
                  WidgetSpan(
                    child: SizedBox(
                      width: 120,
                      height: 50, 
                      child: Card(
                        child: Center(
                          child: Text('朝辞白帝彩云间')
                        )
                      ),
                    )
                  ),
                  TextSpan(text: "千里江陵一日还。", style: TextStyle(color: Colors.green)),
                  TextSpan(text: "两岸猿声啼不住，", style: TextStyle(color: Colors.red)),
                  TextSpan(text: "轻舟已过万重山。", style: TextStyle(color: Colors.deepPurple)),
                ]
              )
            ),
           RichText(
            text: const TextSpan(
              text: "￥",
              style: TextStyle(fontSize: 16, color: Colors.black),
              children: <TextSpan>[
                TextSpan(text: '100', style: TextStyle(fontSize:28, fontWeight: FontWeight.bold)),
                TextSpan(text: '.00', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold)),
              ],
            ),
           ),
          ],
      )),
    );
  }
}
