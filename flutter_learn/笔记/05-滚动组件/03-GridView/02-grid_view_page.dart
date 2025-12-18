import 'package:flutter/material.dart';

class GridViewPage extends StatelessWidget {

  final cityNames = ['北京', '天津', '上海', '重庆', '石家庄','太原', '沈阳', '长春', '哈尔滨','南京', '杭州', '合肥', '福州', '南昌'];

  GridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView',
      home: Scaffold(
        appBar: AppBar(title: const Text('GridView', style: TextStyle(color: Colors.black),),),
        body: GridView.count(
          crossAxisCount: 2,  // 每一行显示多少列
          children: _buildList(),
        ),
      ),
    );
  }

  List<Widget> _buildList() {
    return cityNames.map((city) {
      return _buildItem(city);
    }).toList(); 
  }

  Widget _buildItem(String city) {
    return Container(
      height: 80, 
      margin: const EdgeInsets.only(bottom: 5, right: 5, left: 5),  // 设置 item 的间距
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Text(city, style: const TextStyle(color: Colors.black, fontSize: 20),),
    );
  }

}