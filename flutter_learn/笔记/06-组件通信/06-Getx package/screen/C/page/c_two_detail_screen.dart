import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/counter.dart';
import '../controller/global.dart';

class CTwoDetailScreen extends StatelessWidget {
  CTwoDetailScreen({super.key});

  // 2、获取 GetxController 实例
  // final CounterController _counter = Get.find();
  final _counterController = Get.find<CounterController>();

  // 3、获取全局的 GetxController 实例
  final _globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("C-Two-Detail 页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            Obx(() => Text("counter = ${_counterController.count}", style: TextStyle(fontSize: 18),),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () => _counterController.dec(), 
                  child: Text("增加 counter"),
                ),
                ElevatedButton(
                  onPressed: _counterController.inc, 
                  child: Text("减少 counter"),
                ),
              ],
            ),
            
            // 分割线
            Divider(height: 0.5, color: Colors.red,),

            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: _counterController.list.map((v) {
                  return Text(v);
                }).toList(),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final value = Random().nextInt(100) + 1;
                    _counterController.addItem("item${value.toString()}");
                  }, 
                  child: Text("增加 list"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _counterController.removeLast();
                  }, 
                  child: Text("减少 list"),
                ),
              ],
            ),

            // 分割线
            Divider(height: 0.5, color: Colors.red,),

            Obx(() {
              return Text(_globalController.text.value, style:  TextStyle(fontSize: 15, color: Colors.blue),);  
            }),
            ElevatedButton(
              onPressed: () {
                final random = Random();
                // 汉字 Unicode 范围：0x4E00 到 0x9FFF
                final start = 0x4E00;
                final end = 0x9FFF;
                final codePoint = start + random.nextInt(end - start + 1);
                final text = String.fromCharCode(codePoint);
                _globalController.updateText("随机汉字：$text");
              }, 
              child: Text("修改全局 GetxController"),
            ),

          ],
        ),
      ),
    );
  }
}