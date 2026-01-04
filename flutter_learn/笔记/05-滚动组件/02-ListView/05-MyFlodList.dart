import 'package:flutter/material.dart';

/// 折叠列表
class MyFlodList extends StatelessWidget {
  MyFlodList({super.key});

  final cityNames = {
    '北京': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '顺义区'],
    '上海': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '闸北区', '虹口区'],
    '广州': ['越秀', '海珠', '荔湾', '天河', '白云', '黄埔', '南沙', '番禺'],
    '深圳': ['南山', '福田', '罗湖', '盐田', '龙岗', '宝安', '龙华'],
    '杭州': ['上城区', '下城区', '江干区', '拱墅区', '西湖区', '滨江区'],
    '苏州': ['姑苏区', '吴中区', '相城区', '高新区', '虎丘区', '工业园区', '吴江区']
  };

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _buildList(),
    );
  }

  List<Widget> _buildList() {
    List<Widget> widgets = [];
    for (var key in cityNames.keys) {
      widgets.add(_item(key, cityNames[key]!));
    }
    return widgets;
  }

  Widget _item(String city, List<String> areas) {
    return ExpansionTile(   // 用于展开折叠子项 
      title: Text(city, style: const TextStyle(fontSize: 20, color: Colors.black),),
      children: areas.map((subArea) {
        return _buildSubArea(subArea);
      }).toList(),
    );
  }

  Widget _buildSubArea(String subArea) {
    return FractionallySizedBox(    // 可设置某个方向上填充整个父布局
      widthFactor: 1,   // 宽度填充整个父布局
      child: Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(color: Colors.amber),
        child: Text(subArea, style: const TextStyle(color: Colors.black, fontSize: 16),),
      ),
    );
  }
}