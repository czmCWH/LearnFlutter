import 'package:flutter/material.dart';

class ATwoScreen extends StatefulWidget {
  const ATwoScreen({super.key});

  @override
  State<ATwoScreen> createState() => _ATwoScreenState();
}

class _ATwoScreenState extends State<ATwoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("A-Two-页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("A-Two-页面"),
          ],
        ),
      ),
    );
  }
}