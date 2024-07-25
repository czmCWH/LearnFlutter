import 'package:flutter/material.dart';

/// 上下拉加载
class RefreshLoadMorePage extends StatefulWidget {
  const RefreshLoadMorePage({super.key});

  @override
  State<RefreshLoadMorePage> createState() => _RefreshLoadMorePageState();
}

class _RefreshLoadMorePageState extends State<RefreshLoadMorePage> {

  List<String> cityNames = ['北京', '天津', '上海', '重庆', '石家庄', '哈尔滨', '合肥', '福州','拉萨','西安','兰州','西宁',];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // 监听 ListView 滚动
    _scrollController.addListener(() {
      // 当滑动到底部时，开始加载更多
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '上下拉刷新 ListView',
      home: Scaffold(
        appBar: AppBar(title: const Text('上下拉刷新 ListView', style: TextStyle(color: Colors.black),),),
        body: RefreshIndicator(   // 用于实现下拉刷新
          onRefresh: _handleRefresh,
          child: ListView(
            controller: _scrollController,    // 用于实现上拉加载更多
            children: _buildList(),
          ),
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
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(color: Colors.redAccent),
      child: Text(city, style: const TextStyle(color: Colors.white, fontSize: 20),),
    );
  }

  // 下拉刷新
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
      
    });
    setState(() {
      cityNames = cityNames.reversed.toList();
    });
  }

  // 上拉加载
  _loadData() async {
    await Future.delayed(const Duration(microseconds: 200));
    setState(() {
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }


}