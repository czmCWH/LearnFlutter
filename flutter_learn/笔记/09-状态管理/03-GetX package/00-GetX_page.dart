/*
<https://github.com/jonataslaw/getx>
<https://juejin.cn/post/7020598013986865182#heading-10>

Flutter有几种状态管理器，但是，它们中的大多数都涉及到使用 ChangeNotifier 来更新 widget。
Get 是一个微框架，而不仅仅是一个状态管理器，它的状态管理功能既可以单独使用，也可以与其他状态管理器结合使用。
使用 Get 的响应式编程就像使用 setState 一样简单。

👉 1、安装 Getx
  flutter pub add get
  import 'package:get/get.dart';


👉 2、GetX 的三大支柱
2.1、状态管理
  * 简单状态管理器：GetBuilder
  * 响应式状态管理：GetX、Obx

2.2、路由管理器
在没有 context 的情况下使用 routes/snackbars/dialogs/bottomsheets，GetX 非常适合。
GetX 管理路由只需在 MaterialApp 前面添加“Get”，将其变成 GetMaterialApp。

2.3、依赖管理器
Get 有一个简单而强大的依赖项管理器，仅用 1 行代码检索与 Bloc 或 Controller 相同的类，并且不需要 Provider、context、inheritedWidget。

👉 3、状态管理

忘掉 StatefulWidget! 使用 Get 你永远不会需要它。创建一个无状态类，让一切都成为无状态。如果你需要更新单个组件，就用 GetBuilder 把它包起来，它的状态就会被维护。

* [initial value].obs：通过在初始数据值后面加上`.obs`，把变量声明为响应式。

1、Obx Widget：
  是 GetX中最简单的响应式 Widget。​只需将您的 Rx 变量传递到回调的根范围内，即可自动注册更改。
  Obx不能够嵌套Obx，且这个限制不管你是否抽离了父子组件。

2、GetX Widget：
    GetX<T extends DisposableInterface>(builder: (T controller) => Widget))
    和 Obx 一样，GetX 也是一个响应式 Widget，但是它 只会响应使用 builder 中指定的 DisposableInterface 类型的更改。

3、GetBuilder Widget：
    GetBuilder<T extends GetxController>(builder: (T controller) => Widget))
    GetBuilder 是一个手动的状态管理器，而不是一个响应式 Widget。需要与一个继承自 GetxController 的用户定义的 Controller 配合使用。
    GetBuilder 需要调用 update()，就像你需要调用 Provider 的 notifyListeners() 一样。
    它是一个简单的状态更新器(以块为单位，比如setState())，只是为了完成一个单一的目的（一个_State_ Rebuild），并尽可能地花费最少的资源。
    通常情况下，需要的是同时改变2、3个widget的状态，或者是短暂的状态变化，这种情况下，响应式编程不是不好，而是不适合。响应式编程对 RAM 的消耗比较大，GetBuilder 在 RAM 中是非常高效的。


 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '01-obx_reactive_var.dart';
import '02-getx_reactive_controller.dart';
import '03-get_builder.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: MyGetXStatePage(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyGetXStatePage extends StatelessWidget {
  const MyGetXStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX的基本使用'),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(MyObxReactivePage());
              }, 
              child: const Text('Obx Widget 响应式状态管理')
            ),

            ElevatedButton(
              onPressed: () {
                Get.to(const MyGetXReactivePage());
              }, 
              child: const Text('GetX Widget 响应式状态管理')
            ),

            ElevatedButton(
              onPressed: () {
                Get.to(const MyGetBuilderPage());
              }, 
              child: const Text('GetBuilder Widget 手动状态管理')
            ),

          ],
        ),
      ),
    );
  }
}