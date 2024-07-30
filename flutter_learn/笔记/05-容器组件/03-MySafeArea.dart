/*
<https://docs.flutter.cn/ui/adaptive-responsive/safearea-mediaquery>
<https://api.flutter.dev/flutter/widgets/SafeArea-class.html>

---- 安全边距

👉 1、SafeArea

👉 2、MediaQuery


 */

import 'package:flutter/material.dart';

class MySafeArea extends StatelessWidget {
  
  const MySafeArea({ super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: const Column(
        children: [

        ],
      ),
    );
  }
}
