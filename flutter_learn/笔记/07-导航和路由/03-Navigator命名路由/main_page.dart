import 'package:flutter/Material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  String _pageBackParam = "页面暂无回传";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("首页 - 命名路由"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("其它页面传参数：$_pageBackParam"),

            ElevatedButton(
              onPressed: _pushOne, 
              child: const Text('命名路由跳转（ arguments 传参）'),
            ),

            ElevatedButton(
              onPressed: _pushTwo, 
              child: const Text('自定义路由转场动画'),
            ),

            ElevatedButton(
              onPressed: _pushThree, 
              child: const Text('模态跳转 - MaterialPageRoute.fullscreenDialog'),
            ),

            ElevatedButton(
              onPressed: _pushFour, 
              child: const Text('PageRouteBuilder 自定义转场动画 - 底部弹出'),
            ),

          ],
        ),
      ),
    );
  }

  // 👉 1、页面跳转并接收返回参数
  void _pushOne() async {
    // 跳转并接收返回参数
    final result = await Navigator.pushNamed(context, '/one', arguments: {   // 通过 arguments 传递参数（支持任意类型：字符串、对象、Map等）
        'title': '首页传递数据',
        'number': 25,
      },
    );
    // 更新返回数据
    if (result != null) {
      setState(() {
        _pageBackParam = result.toString();
      });
    }
  }

  // 👉 2、页面跳转自定义转场动画
  void _pushTwo() {
    Navigator.pushNamed(context, "/two");
  }

  // 👉 3、模态页面
  void _pushThree() {
    Navigator.pushNamed(context, "/three");
  }

  // 👉 4、模态页面
  void _pushFour() {
    Navigator.pushNamed(context, "/four");
  }
}