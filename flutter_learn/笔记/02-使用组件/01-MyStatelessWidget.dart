import 'package:flutter/material.dart';

class MyStatelessWidget extends StatelessWidget {
  
  // 定义一个常量构造函数，即初始化参数相同时，创建的对象相同。
  // 该构造函数接收命名参数，textColor 是 required 必须的，tipStr 是 optional 可选的
  const MyStatelessWidget({Key? key, required this.textColor, this.tipStr})
      : super(key: key);

  // 定义常量
  final Color textColor;
  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(
            tipStr ?? '默认文本呢',
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, ),
          ),
        ],
      ),
    );
  }
}

// 使用： MyStatelessWidget(textColor: Colors.red, tipStr: '您好，世界！',)