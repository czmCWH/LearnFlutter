import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "../routes/index.dart";
import 'A/widgets/index.dart';
import './A/index.dart';
/*
 1、Getx 路由跳转
  匿名路由跳转：
    Get.to(NextScreen());   导航到新的页面。
    Get.off(NextScreen());    进入下一个页面，但没有返回上一个页面的选项（用于SplashScreens，登录页面等）。
    Get.offAll(NextScreen());   进入下一个界面并取消之前的所有路由（在购物车、投票和测试中很有用）。
  
  命名路由跳转：
    Get.toNamed("/NextScreen");   导航到下一个页面。
    Get.offNamed("/NextScreen");    导航至新页面并删除前一个页面。
    Get.offAllNamed("/NextScreen");   浏览并删除所有以前的页面。

  关闭路由页面：
    Get.back();   关闭SnackBars、Dialogs、BottomSheets或任何你通常会用Navigator.pop(context)关闭的东西。
    Get.until(CallBack);  返回直到满足 CallBack 中的条件，如：
      Get.until((route) => route.settings.name == '/');
      Get.until((route) => Get.currentRoute == '/');
      Get.until((route) => route.isFirst);

  路由中间件

 2、实现功能如下
  - 默认 push 跳转与返回；
  - 设置转场动画为模态、其它内置动画；
  - Dialog 弹出；
  - sheet 弹出；
  -  Navigator 的语法 push；
 */

class ScreenA extends StatefulWidget {
  const ScreenA({super.key});

  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA>  {

  int _count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('----czm initState A');
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("---- czm dispose A");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('----czm build A');
    return Scaffold(
      appBar: AppBar(title: Text("A页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            _rowState(),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.one);
              }, 
              child: Text("1、跳转到 one")
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.two);
              }, 
              child: Text("2、底部弹出 two")
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.three);
              }, 
              child: Text("3、Getx内置的转场动画 three")
            ),
            ElevatedButton(
              onPressed: () async {
                bool? isConfirmed = await CustomDialog.show<bool>(
                  title: "系统提示",
                  content: "检测到新版本，是否立即更新？",
                  confirmText: "立即更新",
                  cancelText: "稍后再说",
                );
                debugPrint("--- 选择 isConfirmed: $isConfirmed");
              }, 
              child: Text("4、Dialog 弹出")
            ),
            ElevatedButton(
              onPressed: () async {
                final List<String> genders = ["男", "女", "保密"];
                CustomBottomSheet.show(
                  items: genders,
                  onSelected: (index, value) {
                    debugPrint("--- 选择 index: $index, value: $value");
                  },
                );
              }, 
              child: Text("5、sheet 弹出")
            ),
            ElevatedButton(
              onPressed: () async {
                navigator?.push(
                  MaterialPageRoute(builder: (_) {
                      return AFourScreen();
                    },
                  ),
                );
              }, 
              child: Text("6、使用 Navigator 的语法 push")
            ),
            ElevatedButton(
              onPressed: () async {
                Get.toNamed("/notfound");
              }, 
              child: Text("7、导航错误，默认404页面")
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowState() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20,
      children: [
        Text("count = $_count", style: TextStyle(fontSize: 30),),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _count++;
            });
          }, 
          child: Text("增加count")
        ),
      ],
    );
  }
}