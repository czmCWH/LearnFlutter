import 'package:flutter/material.dart';

/// 垂直滚动列表
class VerticalListPage extends StatelessWidget {

  final cityNames = ['北京', '天津', '上海', '重庆', '石家庄','太原', '沈阳', '长春', '哈尔滨','南京', '杭州', '合肥', '福州', '南昌'];

  VerticalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '垂直列表',
      home: Scaffold(
        appBar: AppBar(title: const Text('ListView 垂直滚动', style: TextStyle(color: Colors.black),),),
        body: ListView(
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return cityNames.map((city) {
      return _item(city);
    }).toList();
  }

  Widget _item(String name) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 20),),
    );
  }
}