import 'package:flutter/material.dart';

class UnknownRoutePage extends StatefulWidget {
  const UnknownRoutePage({super.key});

  @override
  State<UnknownRoutePage> createState() => _UnknownRoutePageState();
}

class _UnknownRoutePageState extends State<UnknownRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("404页面"),
          ],
        ),
      ),
    );
  }
}