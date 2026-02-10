import 'package:flutter/Material.dart';

class TwoPage extends StatefulWidget {
  const TwoPage({super.key});

  @override
  State<TwoPage> createState() => _TwoPageState();
}

class _TwoPageState extends State<TwoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TwoPage 页面"),),
      body: Container(
        color: Colors.amber,
        child: Center(
          child: Text("自定义转场动画"),
        )
      ),
    );
  }
}