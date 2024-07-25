import 'package:flutter/material.dart';

/// 垂直滚动列表
class HorizontalListPage extends StatelessWidget {

  final cityNames = ['北京', '天津', '上海', '重庆', '石家庄','太原', '沈阳', '长春', '哈尔滨','南京', '杭州', '合肥', '福州', '南昌'];

  HorizontalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '水平列表',
      home: Scaffold(
        appBar: AppBar(title: const Text('ListView 水平滚动', style: TextStyle(color: Colors.black),),),
        body: SizedBox(
          height: 200,
          child:  ListView(
            scrollDirection: Axis.horizontal,
            children: _buildList(),
          ),
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
      width: 160,
      margin: const EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 20),),
    );
  }
}