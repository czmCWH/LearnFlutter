import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controller/counter.dart';

/*
  2、GetxController 跨页面数据管理：
    - Get.put 用于实例化 GetxController；⚠️，只能实例化一次！
    - Get.find 获取 put 或 binding GetxController 实例；
 */
class CTwoScreen extends StatelessWidget {
  
  CTwoScreen({super.key});

  // 1、Get.put 创建 GetxController 实例
  final CounterController _counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("C-Two-页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [

            // 1、使用 GetBuilder - 简单状态管理器
            GetBuilder<CounterController>(
              builder: (ctrl) {
                return Text("计数：${ctrl.norCount}", style: TextStyle(fontSize: 15),);
              }
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () => _counterController.decNor(), 
                  child: Text("增加 norCounter"),
                ),
                ElevatedButton(
                  onPressed: _counterController.incNor, 
                  child: Text("减少 norCount"),
                ),
              ],
            ),

            Divider(height: 1, color: Colors.red,),

            // 2、Obx 使用 GetxController 中 响应式数据

            Obx(() {
              return Text("counter = ${_counterController.count}", style: TextStyle(fontSize: 18),);
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () => _counterController.dec(), 
                  child: Text("增加 counter"),
                ),
                ElevatedButton(
                  onPressed: _counterController.inc, 
                  child: Text("减少 counter"),
                ),
              ],
            ),

            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.cTwo + Routes.detail);
              }, 
              child: Text("跳转到 detail")
            ),

            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: _counterController.list.map((v) {
                  return Text(v);
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}