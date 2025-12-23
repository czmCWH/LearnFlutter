import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterController extends GetxController{
  var count = 0.obs;
  void increase() => ++count;
  void reduce() => --count;
}

class MyGetXReactivePage extends StatelessWidget {
  
  const MyGetXReactivePage({super.key});

  Widget get _initGetX => GetX<CounterController>(
    init: CounterController(),
    builder: (controller) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('数量为: ${controller.count}'),
        ElevatedButton(
          onPressed: () {
            controller.increase();
          },
          child: const Text('增加+'),
        ),
      ],
    ),
  );

  Widget get _defaultControllerGetX => GetX<CounterController>(
    builder: (controller) => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('数量为: ${controller.count}'),
        ElevatedButton(
          onPressed: () {
            controller.increase();
          },
          child: const Text('增加+'),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    
    /// 通过依赖注入方式实例化的控制器
    final counter = Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(title: const Text('GetX Widget 响应式状态管理'),),
      body: Center(
          child: Column(
            
            // 如下所示，创建3个 GetX 都是使用相同的 Controller
            // 这是因为 Get.put() 已经生成了一个 Controller，所以后续不需要再次生成

            children: [
              // 在 GetX 创建的时候传入 Controller 
              _initGetX,
              // 在 GetX 创建的时候不传入 Controller 
              _defaultControllerGetX,
              // 在 GetX 创建的时候传入 依赖注入的 Controller 
              _putGetX(counter),
            ],
          )
        ),
    );
  }

  Widget _putGetX(CounterController controller) {
    return GetX<CounterController>(
      init: controller,
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('数量为: ${controller.count}'),
          ElevatedButton(
            onPressed: () {
              controller.increase();
            },
            child: const Text('增加+'),
          ),
        ],
      ),
    );

  }

}

