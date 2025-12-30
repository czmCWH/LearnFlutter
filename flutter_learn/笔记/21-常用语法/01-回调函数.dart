import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {

  final Function(int index) delItem;
  final VoidCallback? onPressed;


  const MyWidget({super.key, this.onPressed});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}