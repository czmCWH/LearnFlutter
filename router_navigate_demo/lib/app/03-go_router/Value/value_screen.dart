import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'extra_screen.dart';

/*
  1、go_router 插件页面跳转时传递参数（Go / Push）有3种方式：
    - Path 路径参数，只能传字符串，不能传复杂对象。
    - Query 查询参数，url字符串方式拼接传递。
    - extra 参数，参数为任意 Dart 对象。

   这3种基本方式，获取参数都可以从构造 GoRoute 时获取；或者直接在页面中获取。
  
  2、go_router 插件页面 pop 返回时传递参数
    方式1，context.pop(result) 直接回传参数；
    方式2，传递 ValueNotifier 类型的 extra 参数，监听回传；
    方式3，状态管理插件，如：Provider；

 */

class ValueScreen extends StatefulWidget {
  const ValueScreen({super.key});

  @override
  State<ValueScreen> createState() => _ValueScreenState();
}

class _ValueScreenState extends State<ValueScreen> {

  int _count = 10;

  // 页面 pop 弹出回传参数
  int? _returnParam;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("go_router 参数传递"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            GestureDetector(
              child: Text("参数 count: $_count \n 点击加+1", style: TextStyle(fontSize: 18),),
              onTap: () {
                setState(() {
                  _count++;
                });
              },
            ),

            ElevatedButton(
              onPressed: () {
                context.push("/path/$_count/value页面");
              }, 
              child: const Text('页面跳转 - 传递 Path 路径参数'),
            ),

            ElevatedButton(
              onPressed: () {
                // context.push('/query?desc=count_$_count');
                
                // 或动态构造
                final uri = Uri(
                  path: '/query',
                  queryParameters: {'desc': 'count_$_count'},
                ).toString();
                context.push(uri);
              }, 
              child: const Text('页面跳转 - 传递 Query 查询参数'),
            ),

            ElevatedButton(
              onPressed: () {
                User user = User(_count, "张三");
                context.push("/extra", extra: user);
              }, 
              child: const Text('页面跳转 - 传递 extra 参数'),
            ),

            Divider(color: Colors.red, height: 1, thickness: 0.5,),

            Text("pop 回传: $_returnParam"),
            ElevatedButton(
              onPressed: () async {
                final result = await context.push<int>('/return');

                if (result != null) {
                  debugPrint('收到的返回值: $result');
                  setState(() {
                    _returnParam = result;
                  });
                }
              }, 
              child: const Text('pop回传参数 - await push 方式'),
            ),

            ElevatedButton(
              onPressed: () async {
                final notifier = ValueNotifier<int?>(null);
                notifier.addListener(() {
                  debugPrint('收到的返回值: ${notifier.value}');
                  setState(() {
                    _returnParam = notifier.value;
                  });
                });

                // 通过 extra 传递监听对象
                context.push('/return', extra: notifier);
              }, 
              child: const Text('pop回传参数 - extra 参数 notifier 方式'),
            ),

            ElevatedButton(
              onPressed: () {
                // 通过 extra 传递回调函数
                context.push('/return', extra: (int? value) {
                  setState(() {
                    _returnParam = value;
                  });
                });
              }, 
              child: const Text('pop回传参数 - extra 参数 回调函数 方式'),
            ),


          ],
        ),
      ),
    );
  }
}