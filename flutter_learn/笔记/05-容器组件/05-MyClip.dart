/*
https://api.flutter-io.cn/flutter/widgets/ClipOval-class.html

----- 裁剪
👉 1、ClipOval
子组件为正方形时剪裁成内贴圆形；为矩形时，剪裁成内贴椭圆

👉 2、ClipRRect
将子组件剪裁为圆角矩形


👉 3、ClipRect
默认剪裁掉子组件布局空间之外的绘制内容（溢出部分剪裁）


👉 4、ClipPath
按照自定义的路径剪裁

 */


import 'package:flutter/material.dart';

class MyClip extends StatelessWidget {
  
  const MyClip({ super.key });

  @override
  Widget build(BuildContext context) {
    // 头像  
    Widget avatar = Image.asset("images/WhiteFlower.jpg", width: 160.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('裁剪容器'),
      ),
      body:  Column(
        children: [
          avatar, //不剪裁

          ClipOval(child: avatar), //剪裁为圆形
          ClipRRect( //剪裁为圆角矩形
            borderRadius: BorderRadius.circular(5.0),
            child: avatar,
          ), 
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: .5,//宽度设为原来宽度一半，另一半会溢出
                child: avatar,
              ),
              Text("你好世界", style: TextStyle(color: Colors.green),)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect(//将溢出部分剪裁
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5,//宽度设为原来宽度一半
                  child: avatar,
                ),
              ),
              Text("你好世界",style: TextStyle(color: Colors.green))
            ],
          ),
        ],
      )
    );
  }
}
