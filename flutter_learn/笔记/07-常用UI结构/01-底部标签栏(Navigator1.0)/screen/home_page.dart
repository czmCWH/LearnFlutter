import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("---- home initState");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    debugPrint("---- home dispose");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("---- home build");
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("首页"),
        ],
      ),
    );
  }

}