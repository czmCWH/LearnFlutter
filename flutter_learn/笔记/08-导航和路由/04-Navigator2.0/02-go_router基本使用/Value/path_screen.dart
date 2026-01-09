import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PathScreen extends StatefulWidget {
  final String? id;
  final String? name;
  const PathScreen({super.key, this.id, this.name});

  @override
  State<PathScreen> createState() => _PathScreenState();
}

class _PathScreenState extends State<PathScreen> {
  @override
  Widget build(BuildContext context) {
    
    final id = GoRouterState.of(context).pathParameters['id'];
    debugPrint("--- 直接获取路径参数：id = $id");

    return Scaffold(
      appBar: AppBar(title: Text("接收 Path 路径参数"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("接收参数，id = ${widget.id}, name = ${widget.name}"),
          ],
        ),
      ),
    );
  }
}