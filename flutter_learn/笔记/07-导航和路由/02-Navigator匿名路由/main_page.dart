import 'bottom_dialog.dart';
import 'center_dialog.dart';
import 'one_page.dart';
import 'three_page.dart';
import 'two_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
  --- Navigator 组件 - 匿名路由
    1、使用步骤：
      1、Navigator.push，跳转新页面，需创建一个 MaterialPageRoute 实例传递。
      2、Navigator.pop，返回上一个页面。
      3、参数传递，与父子组件传递一致，即：页面定义 final 参数，通过构造函数接收。
   
    2、实现功能：
      - 页面跳转传参；
      - 页面转场动画；
      - iOS模态弹窗；
      - 自定义弹窗；
 */

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
      appBar: AppBar(title: Text("匿名路由示例"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [

            Text("其它页面传参数：$_pageBackParam"),
            ElevatedButton(
              onPressed: _pushOne, 
              child: Text("页面跳转参数传递"),
            ),

            ElevatedButton(
              onPressed: () => _pushWithAnimation(context),
              child: const Text('自定义转场动画'),
            ),
            
            ElevatedButton(
              onPressed: () {
                // ⚠️，如果需要高度定制iOS模态效果，推荐使用 modal_bottom_sheet 插件
                showCupertinoModalPopup(
                  context: context, 
                  builder: (context) {
                    return ThreePage();
                  }
                );
              },
              child: const Text('从底部弹出详情页'),
            ),

            ElevatedButton(
              onPressed: () => _showCenterDialog(context),
              child: const Text('中间弹窗'),
            ),
            
            ElevatedButton(
              onPressed: () => _showBottomSheet(context),
              child: const Text('底部弹窗'),
            ),
          ],
        ),
      ),
    );
  }

  // 1、页面跳转参数传递
  void _pushOne() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OnePage(param: "我是首页！"),
      ),
    );
    // 更新返回的参数
    if (result != null) {
      setState(() {
        _pageBackParam = result as String;
      });
    }
  }

  // 2、自定义转场动画跳转
  void _pushWithAnimation(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return TwoPage();
        },
        // 转场动画：从右到左滑入，透明度从0到1
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          
           // 主动画：用于进入（push）
            // secondaryAnimation：用于退出（pop），但通常我们只用主 animation 并让它反向

            // 缩放：从 0.8 到 1.0
            final scaleAnimation = Tween<double>(
              begin: 0.8,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic, // 进入时缓动
                reverseCurve: Curves.easeInCubic, // 返回时反向缓动
              ),
            );

            // 透明度：从 0 到 1
            final opacityAnimation = Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeIn,
              ),
            );

            // 垂直位移：从 30px 下方向上移到 0
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0, 0.1), // 相当于向下偏移 10% 屏幕高度
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutQuad,
                reverseCurve: Curves.easeInQuad,
              ),
            );

            return FadeTransition(
              opacity: opacityAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: child,
                ),
              ),
            );


        },
        transitionDuration: const Duration(milliseconds: 300), // 动画时长
      ),
    );
  }


   // 中间弹窗
  void _showCenterDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // 点击空白处关闭
      builder: (context) {
        return CenterDialog(title: "清平乐·六盘山", content: "天高云淡，望断南飞雁。不到长城非好汉，屈指行程二万。六盘山上高峰，红旗漫卷西风。今日长缨在手，何时缚住苍老？");
      },
    ).then((value) {
      // 接收弹窗返回的参数
      if (value != null) {
        setState(() {
          _pageBackParam = value;
        });
      }
    });
  }

  // 底部弹窗
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 允许弹窗高度自适应
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:(context) {
        return BottomDialog(title: "清平乐·六盘山", message: "天高云淡，望断南飞雁。不到长城非好汉，屈指行程二万。六盘山上高峰，红旗漫卷西风。今日长缨在手，何时缚住苍老？");
      },
    ).then((value) {
      // 接收弹窗返回的参数
      if (value != null) {
        setState(() {
          _pageBackParam = value;
        });
      }
    });
  }

}