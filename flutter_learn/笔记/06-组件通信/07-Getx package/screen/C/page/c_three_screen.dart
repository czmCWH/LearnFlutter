import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import '../controller/status.dart';

/*
  1、GetView 自动注入 GetxController
    - 作用：省去 Get.find()；
    - 可自动获取 binding 到 GetPage 上的 GetxController；
    - GetxController 的生命周期；

    * Obx(builder: )，构建响应式UI。专门监听 Rx 类型变量，当值发生变化时 rebuild Widget 子树。
    * GetView<T>，用于简化 GetxController 的访问，它继承自 StatelessWidget。
    * GetX(builder: )，精确监听指定 GetxController 中的 Rx 类型变量。
 */

class CThreeScreen extends GetView<StatusController> {
  const CThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    // ⚠️，如果没有 binding GetxController 则需要 put，GetView 中才能使用。
    Get.put(StatusController());

    return Scaffold(
      appBar: AppBar(title: Text("C-Three-页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [

            // 1、Obx 访问响应式变量
            Obx(() {
              return Text("Obx 状态：${controller.result}");
            }),

            // 2、GetBuilder 简单状态管理器
            GetBuilder<StatusController>(
              builder: (con) {
                return Column(
                  children: [
                    Text("GetBuilder 状态：${con.result}"),
                    ElevatedButton(
                      onPressed: () {
                        con.reverse();
                      }, 
                      child: Text("更新状态2"),
                    ),
                  ],
                );
              }
            ),

            // 3、GetX(builder:) 精确监听 Controller 中的 RX 类型数据
            GetX<StatusController>(
              builder: (controller) {
                return Text("GetX 状态：${controller.result}");
              }
            ),
            
            ElevatedButton(
              onPressed: () {
                controller.reverse();
              }, 
              child: Text("更新状态1"),
            ),

            Divider(height: 1, color: Colors.amber,),

           

            
          ],
        ),
      ),
    );
  }
}