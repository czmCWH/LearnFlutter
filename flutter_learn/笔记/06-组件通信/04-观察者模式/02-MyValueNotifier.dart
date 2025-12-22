import 'package:flutter/material.dart';

/*
 <https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html>

 1、ValueNotifier<T>
  ValueNotifier 继承自 ChangeNotifier，它只包含单个值。

  当 ValueNotifier.value 被替换为与旧值不相等的值（通过相等运算符 == 计算得出）时，此类会通知其监听器 listeners。
  注意，ValueNotifier<List<int>> 在列表内容更改时不会通知其监听器。对于此种情况，可通过继承 ChangeNotifier 来实现实现。

  核心方法：
    - .value（读写）
    - .addListener()
    - .removeListener()

  特点：
    - 响应式；
    - 配合 ValueListenableBuilder 实现自动 rebuild UI；而不需要手动 addListener 再进行 setState 更新 UI。

 */

class MyValueNotifier extends StatefulWidget {
  const MyValueNotifier({super.key});

  @override
  State<MyValueNotifier> createState() => _MyValueNotifierState();
}

class _MyValueNotifierState extends State<MyValueNotifier> {
  
  // 1. 创建 ValueNotifier（通常在 State 中创建，确保生命周期匹配）
  final _counter = ValueNotifier<int>(0);

  @override
  void dispose() {
    _counter.dispose(); // 释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 2. 使用 ValueListenableBuilder 监听并构建 UI
          ValueListenableBuilder<int>(
            valueListenable: _counter,
            builder: (context, value, child) {
              print('Rebuilding counter text: $value'); // 可观察 rebuild
              return Text(
                '点击次数: $value',
                style: const TextStyle(fontSize: 24),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // 3. 更新值（会自动触发 UI 更新）
              _counter.value++;
            },
            child: const Text('增加'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _counter.value = 0;
            },
            child: const Text('重置'),
          ),
        ],
      ),
    );
  }
}