/*

MyTest
 */

import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyTest(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyTest extends StatefulWidget {

  const MyTest({ Key? key }) : super(key: key);

  @override
  State<MyTest> createState() {
    return _MyTest();
  }
}

class _MyTest extends State<MyTest> {
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: const Column(children: [],)
    );
  }

}
