import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import '01-obx_reactive_var.dart';
import '02-getx_reactive_controller.dart';
import '03-get_builder.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: MyGetXStatePage(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyGetXStatePage extends StatelessWidget {
  const MyGetXStatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX的基本使用'),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(MyObxReactivePage());
              }, 
              child: const Text('Obx Widget 响应式状态管理')
            ),

            ElevatedButton(
              onPressed: () {
                Get.to(const MyGetXReactivePage());
              }, 
              child: const Text('GetX Widget 响应式状态管理')
            ),

            ElevatedButton(
              onPressed: () {
                Get.to(const MyGetBuilderPage());
              }, 
              child: const Text('GetBuilder Widget 手动状态管理')
            ),

          ],
        ),
      ),
    );
  }
}