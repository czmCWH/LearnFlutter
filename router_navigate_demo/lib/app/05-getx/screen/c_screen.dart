import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

/*
  <https://github.com/jonataslaw/getx/blob/master/documentation/zh_CN/state_management.md>
  <https://github.com/jonataslaw/getx/blob/master/documentation/zh_CN/dependency_management.md>

  👉 1、Getx 插件状态管理
    Get 有两个不同的状态管理器：响应式状态管理器、简单的状态管理器；

  1.1、响应式状态管理器 - value.obs + Obx()
   Getx 的响应式状态管理器基于 StreamBuilder 封装，使用步骤如下：
    - 定义响应式数据；  -  可观察状态，即Rx
      最简单的方式：值.obs，如："".obs、false.obs、0.0.obs 等；
    - 在 Obx(builder: builder) 组件里访问响应式数据； -  Rx 的 "观察者"
  
  1.2、简单的状态管理 - GetxController + GetBuilder
    - 在 GetxController 子类中定义多个状态 或者 任何控制器（如：TextEditController）；
    - GetBuilder(builder: ) 访问 GetxController 中的状态构建UI；

  👉 2、依赖管理 - 核心
  Get有一个简单而强大的依赖管理器，它允许只用1行代码就能检索到与你的 Bloc 或 Controller 相同的类，无需 Provider context，无需 InheritedWidget。
  作用：
    - 跨页面响应式状态管理；

  向 Get 添加 GetxController 依赖的几种方式：
    - Get.put()：不使用控制器实例也会被创建；
    - Get.lazyPut()：懒加载方式创建实例，只有在使用时才创建；
    - Get.putAsync()：Get.put() 的异步版本；
    - Get.create()：每次使用都会创建一个新的实例；
  
  从 Get 中获取 GetxController 的几种方式：
    - Get.find
    - class xxx extends GetView {} 

  👉 3、Binding API - 将 GetxController 绑定到 页面
  GetX Binding 在项目初始化时把所有需要进行状态管理的控制器进行统一初始化，在需要使用的地方，直接通过 Get.find 来获取使用。
    - 绑定到 GetMaterialApp，GetxController 的生命周期跟随应用；
    - 绑定到 GetPage，则 GetxController 的生命周期跟随路由；

  👉 4、GetView - 简化页面中获取 GetxController
  GetView 是对 StatelessWidget 封装，用于当 Widget 中只有一个 GetxController 时，它提供了一个 controller 的 getter，从而避免写 Get.find。

  👉 5、使用响应式数据的方式：
    - Obx(builder: ) 轻量级、极简的响应式状态监听 Widget。专门监听 Rx 类型变量；
    - GetBuilder(builder: ) 非响应式状态管理，依赖普通 Dart 变量 + 手动 update() 触发重建。
    - GetX(builder: )，只监听指定的变量，功能和 Obx 一致，但写法更繁琐，是 Obx 的 “前身”。

 */

class ScreenC extends StatelessWidget {
  const ScreenC({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("C页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.cOne);
              }, 
              child: Text("响应式状态管理器")
            ),

            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.cTwo);
              }, 
              child: Text("跨页面状态管理")
            ),

            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.cThree);
              }, 
              child: Text("GetView 自动注入 GetxController")
            ),

          ],
        ),
      ),
    );
  }
}