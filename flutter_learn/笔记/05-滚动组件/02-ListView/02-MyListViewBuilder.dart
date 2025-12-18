import 'package:flutter/material.dart';

// --- ListView.builder 按需构建大量子元素列表

class MyListViewBuilder extends StatefulWidget {
  const MyListViewBuilder({super.key});

  @override
  State<MyListViewBuilder> createState() => _MyListViewBuilderState();
}

class _MyListViewBuilderState extends State<MyListViewBuilder> {
  // 滚动控制器
  late final ScrollController _scrollController;
  // 列表项的内容
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    // 初始化数据
    items = List.generate(15, (index) => '第 ${index + 1} 个 Item');
    
    // 监听滚动事件（用于加载更多）
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // 判断是否滚动到底部，用于加载更多数据
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 100) {
      debugPrint('--- 接近底部，开始加载更多数据');
      Future.delayed(const Duration(seconds: 1), () {
        _loadMoreData();
      });
    }
  }

  void _loadMoreData() {
    // 模拟加载更多数据
    setState(() {
      int currentLength = items.length;
      items.addAll(
        List.generate(20, (index) => '第 ${currentLength + index + 1} 个 Item')
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,  // 滚动控制器
      itemCount:  items.length,  // 列表项数量
      itemBuilder: (context, index) { // 根据索引构建列表项
        // 构建每个列表项
        return _buildListItem(index);
      },
      padding: const EdgeInsets.all(8.0), // 列表的内边距
      scrollDirection: Axis.vertical,   // 滚动方向 
      physics: const ClampingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
    );
  }

  // 构建列表项
  Widget _buildListItem(int index) {
    return Card(
      margin: const EdgeInsets. symmetric(vertical: 8, horizontal: 12),
      elevation: 2,   // 点击时波纹深度
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:  Colors.primaries[index % Colors.primaries.length],
          child: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          items[index],
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('这是第 ${index + 1} 个列表项的描述'),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[600],
        ),
        onTap: () {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('点击了 ${items[index]}'),
          //     duration: const Duration(milliseconds: 1000),
          //   ),
          // );
        },
      ),
    );
  }
}