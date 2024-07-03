/*

-------- 对齐与相对定位

👉 1、Align

Align 将其子项在自己内部对齐，并根据子项的大小来调整自己的大小。



 */

import 'package:flutter/material.dart';


class MyAlign extends StatelessWidget {
  
  const MyAlign({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: const Center(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
