import 'package:flutter/material.dart';

// AnimatedSwitcher 组件，组件更换动画
class MyAnimatedSwitcher extends StatefulWidget {
  const MyAnimatedSwitcher({super.key});

  @override
  State<MyAnimatedSwitcher> createState() => _MyAnimatedSwitcherState();
} 

class _MyAnimatedSwitcherState extends State<MyAnimatedSwitcher> {

  bool _isLoading = true;
  int _count = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 10,
        children: [
          Container(
            color: Colors.amber,
            width: 300,
            height: 300,
            // 👉 1、当 AnimatedSwitcher.child 更换为不同类型的组件时，会默认添加动画。否则不会添加动画。
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: _isLoading 
                      ? const Center(child: CircularProgressIndicator(),)
                      : Image.network("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            }, 
            child: const Text("切换组件类型"),
          ),
          // const SizedBox(height: 10,),
          Container(
            color: Colors.amber,
            width: 300,
            height: 100,
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              // 👉 2、AnimatedSwitcher 的 child 为 Text，当修改 _count 时组件类型并未改变，因此 AnimatedSwitcher 默认不会添加动画。
              // 如果动画的组件不修改，只是组件内容改变，则需要通过 Key 直接告诉 AnimatedSwitcher 其 child 已经改变。
              // key 的取值为 ValueKey(_count)；或者  UniqueKey()
              child: Text("$_count", key: UniqueKey(), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),),
            ),
          ),
          // const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            }, 
            child: const Text("修改组件内容"),
          ),
          Container(
            color: Colors.amber,
            width: 300,
            height: 100,
            // 👉 3、AnimatedSwitcher 默认效果为 FadeTransition，即不透明度从消失到慢慢亮起。
            // 它还支持许多动画，可以通过其 transitionBuilder 属性修改。
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: Text("$_count", key: ValueKey(_count), style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            ),
          ),
          // const SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            }, 
            child: const Text("修改动画效果"),
          ),
        ],
      ),
    );
  }
}
