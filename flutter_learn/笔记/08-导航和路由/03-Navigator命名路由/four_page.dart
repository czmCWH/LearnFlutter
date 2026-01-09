import 'package:flutter/material.dart';

class FourPage extends StatefulWidget {
  const FourPage({super.key});

  @override
  State<FourPage> createState() => _FourPageState();
}

class _FourPageState extends State<FourPage> {
  @override
  Widget build(BuildContext context) {
    return Align(   // ⚠️，控制页面内容在底部开始显示
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.6, // 占屏幕高度的 60%
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 关键：避免 Column 撑满
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '自定义转场动画-底部弹出',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, '模态页面返回：确认'),
                  child: const Text('确认返回'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}