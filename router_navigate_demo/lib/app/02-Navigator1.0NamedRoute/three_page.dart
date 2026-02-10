import 'package:flutter/Material.dart';

class ThreePage extends StatefulWidget {
  const ThreePage({super.key});

  @override
  State<ThreePage> createState() => _ThreePageState();
}

class _ThreePageState extends State<ThreePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ThreePage 页面"),),
      body: Container(
        color: Colors.purple,
        child: Center(
          child: Text("模态页面", style: TextStyle(color: Colors.white),),
        )
      ),
    );
  }
}