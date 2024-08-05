import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GetBuilderController extends GetxController {
  var count = 0.obs;
  
  void increase() {
    ++count;
    update();
  }
  void reduce() {
    --count;
    update(['id_reduce']);
  }

  @override
  void onInit() {
    super.onInit();
    debugPrint('--- 初始化, 可执行: 初始网络请求、为 Widget Controller 添加监听');
  }

  @override
  void onReady() {
    super.onReady();
    debugPrint('--- 加载完成');
  }

  @override
  void onClose() {
    super.onClose();
    debugPrint('--- 释放控制器，操作: 销毁Widget Controller');
  }

}

class MyGetBuilderPage extends StatelessWidget {
  const MyGetBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetBuilder Widget 手动状态管理'),),
      body: GetBuilder<GetBuilderController>(
        init: GetBuilderController(),
        builder: (controller) => Center(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('数量: ${controller.count}'),
                ElevatedButton(
                  onPressed: () {
                    controller.increase();
                  },
                  child: const Text('增加 +'),
                ),

                ElevatedButton(
                  onPressed: () => Get.to(const MyGetBuilderSubPage()),
                  child: const Text('跳转到 Sub Page'),
                ),
              ],),


            ],
          ),
        ),
      ),
    );
  }
}

class MyGetBuilderSubPage extends StatelessWidget {
  const MyGetBuilderSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetBuilder使用上一个页面的状态'),),
      body: GetBuilder<GetBuilderController>(
        builder: (controller) => Center(
          child: Column(
            children: [
              Text('数量: ${controller.count}'),
              ElevatedButton(
                onPressed: () {
                  controller.increase();
                },
                child: const Text('增加 +'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}