import 'package:flutter/material.dart';
import '../MyInheritedWidget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {

    // 获取父级的状态
    String? userName = MyInheritedWidget.of(context)?.userName;

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
      ),
      child: Text('登录：$userName'),
    );
  }
}