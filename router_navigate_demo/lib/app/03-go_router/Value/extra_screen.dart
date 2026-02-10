import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExtraScreen extends StatefulWidget {

  final User? user;

  const ExtraScreen({super.key, this.user});

  @override
  State<ExtraScreen> createState() => _ExtraScreenState();
}

class _ExtraScreenState extends State<ExtraScreen> {
  @override
  Widget build(BuildContext context) {
    final user = GoRouterState.of(context).extra as User?;
    debugPrint("--- 直接获取 extra 参数：user = ${user.toString()}");

    return Scaffold(
      appBar: AppBar(title: Text("接收 extra 参数"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("接收参数，user = ${widget.user.toString()}"),
          ],
        ),
      ),
    );
  }
}

class User {
  int id;
  String name;

  User(this.id, this.name);

  @override
  String toString() {
    // TODO: implement toString
    return "{id: $id, name: $name}";
  }
}