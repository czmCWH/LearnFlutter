/*

Material2 Butttons：https://docs.flutter.cn/ui/widgets/material2#Buttons

1、ElevatedButton 
ElevatedButton 是一个凸起的材质矩形按钮。应避免在 dialogs、cards 等已经升高的内容上使用它。

2、TextButton
TextButton 一般在 toolbar、dialogs 或嵌入其它容器中使用，使用它的 `padding` 以便其显而易见。
TextButton 没有可见的边界，因此必须依赖其相对于其他内容的位置来确定上下文。

3、OutlinedButton
OutlinedButton 本质上是一个带有轮廓边框的 TextButton。

4、IconButton
IconButton 不能设置背景颜色、title标题。因为 IconButton 通常仅显示在父窗口小部件的背景之上。

 */

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button 的使用'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print("点击，on pressed");
              },
              onLongPress: () {
                print("长按，on long press");
              },
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(const TextStyle(backgroundColor: Colors.purple, fontSize: 15, )),  // 文字的背景颜色和大小
                backgroundColor: MaterialStateProperty.all(Colors.amberAccent),   // 按钮背景颜色
                foregroundColor: MaterialStateProperty.all(Colors.green),   // 文字的颜色
                overlayColor: MaterialStateProperty.all(Colors.red),    // 点击时水波纹的颜色
                // padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 5, 10, 5)),  // 设置按钮child的内边距
                minimumSize: MaterialStateProperty.all(Size(50, 30)), // 按钮的最小尺寸
                alignment: Alignment.topLeft,   // 设置按钮child的对齐方式
              ),
              child: const Text('ElevatedButton'),
            ),

            ElevatedButton.icon(
              onPressed: () {

              },
              icon: const Icon(Icons.search, color: Colors.yellow, size: 20,),
              label: const Text('搜索'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.green, // 设置text、Icon 的颜色，text以次为主，icon以自身为主
                backgroundColor: Colors.orange, // 背景颜色
                textStyle: const TextStyle(color: Colors.black, fontSize: 20,),
                minimumSize: Size(90, 50),
              ),
            ),

            TextButton(
              onPressed: () {},
              child: const Text('文本按钮'),
              style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Colors.yellow,   // 背景颜色
              ),
            ),


            OutlinedButton(
              onPressed: () {
                debugPrint('测试打印');
              },
              child: const Text('边框按钮'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,    // 文本颜色
                backgroundColor: Colors.amberAccent,    // 按钮背景颜色
                side: const BorderSide(   // 设置边框的样式
                  color: Colors.cyanAccent,
                  width: 2,
                  style: BorderStyle.solid,
                ),
                shape: const RoundedRectangleBorder(      // 设置边框形状
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10), right: Radius.circular(20)),
                ),
                textStyle: const TextStyle(fontSize: 15),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              ),
            ),

            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.favorite, size: 30,),
              label: const Text('爱心'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.grey,
                
              ),
            ),

            IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.android),
              iconSize: 30,       // 需要通过 IconButton.iconSize设置Icon的大小，而不是Icon自身
              color: Colors.red,
            ),

          ],
        ),
      ),
    );
  }
}
