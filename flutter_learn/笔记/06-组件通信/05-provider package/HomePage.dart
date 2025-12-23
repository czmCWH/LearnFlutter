import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './CounterModel.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ChangeNotifierProvider 示例')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 👉 1、Consumer 在组件树的任何地方都可以拿到状态模型。当状态发生改变时，Consumer 会自动触发其子树的重建。
            Consumer<CounterModel>(
              builder: (BuildContext context, CounterModel value, Widget? child) {
                return Text(
                  '当前计数: ${value.count}',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),

            const SizedBox(height: 20),

            // 👉 2、context.read<T>() 只获取状态 T 的引用，不监听变化。通常在 事件回调、非 build 中 等场景使用。
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterModel>().increment();
                  },
                  child: const Text('增加'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterModel>().decrement();
                  },
                  child: const Text('减少'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 👉 3、Provider.of 从 widget 树中获取由 Provider 提供的类型为 T 的数据实例的方法。适用于 不需要模型中的 数据 来改变 UI 的场景。
            ElevatedButton(
              onPressed: () {
                int count = Provider.of<CounterModel>(context, listen: false).count;
                debugPrint('--- nameValue = $count');
              }, 
              child: const Text('访问响应式模型中的数据'),
            ),

            const SizedBox(height: 20),

            const MyWatchWidget(),
            
          ],
        ),
      ),
    );
  }
}

class MyWatchWidget extends StatelessWidget {
  const MyWatchWidget({super.key});

  @override
  Widget build(BuildContext context) {

    // 👉 4、context.watch<T>()：会自动监听 T 的变化，当前 widget 会 rebuild。在 build 方法内使用。
    final counter = context.watch<CounterModel>(); 

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '当前计数: ${counter.count}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => context.read<CounterModel>().increment(),
            child: const Text('增加'),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () => context.read<CounterModel>().decrement(),
            child: const Text('减少'),
          ),
        ],
      ),
    );
  }
}