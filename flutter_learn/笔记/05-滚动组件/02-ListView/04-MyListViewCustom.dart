

// --- ListView.custom 自定义列表项，通过 childrenDelegate 参数来控制子项的创建和管理。

/*
// 关键参数说明
 SliverChildBuilderDelegate(
  (context, index) => _buildItem(index),  // 构建函数
  childCount: 100,                         // 子项总数
  addAutomaticKeepAlives: true,           // 保持项的状态
  addRepaintBoundaries: true,             // 优化重绘
  addSemanticIndexes:  true,               // 添加语义
  semanticIndexOffset: 0,                 // 语义偏移
 ) 
 */

import 'package:flutter/material.dart';

class MyListViewCustom extends StatelessWidget {
  const MyListViewCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      // childrenDelegate 是必需参数
      childrenDelegate: SliverChildListDelegate(  // 接收一个 SliverChildListDelegate 构建列表项
        // 一次性创建所有子项
        List.generate(100, (index) {
          return Card(
            color: Colors.green[100],
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text("第 ${index + 1} 个"),
              subtitle: Text('这是第 ${index + 1} 个列表项'),
              onTap: () {
                debugPrint("--- 点击了 $index");
              },
            ),
          );
        }),
      ),
      padding: const EdgeInsets.all(8),
    );
  }
}