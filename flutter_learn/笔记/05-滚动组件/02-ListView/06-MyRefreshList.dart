import 'package:flutter/material.dart';

/*
  1、RefreshIndicator 下拉刷新组件



 */

// 下拉刷新、上拉加载列表
class MyRefreshList extends StatefulWidget {
  const MyRefreshList({super.key});

  @override
  State<MyRefreshList> createState() => _MyRefreshListState();
}

class _MyRefreshListState extends State<MyRefreshList> {

  List<String> cityNames = ['北京', '天津', '上海', '重庆', '石家庄', '哈尔滨', '合肥', '福州','拉萨','西安','兰州','西宁',];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // 监听 ListView 滚动
    _scrollController.addListener(_scrollViewScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(   // 用于实现下拉刷新
      onRefresh: _handleRefresh,
      child: ListView(
        controller: _scrollController,    // 用于实现上拉加载更多
        children: _buildList(),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> _buildList() {
    return cityNames.map((city) {
      return Container(
        height: 80,
        margin: const EdgeInsets.only(bottom: 5),
        decoration: const BoxDecoration(color: Colors.redAccent),
        child: Text(city, style: const TextStyle(color: Colors.white, fontSize: 20),),
      );
    }).toList();
  }

  Future<void> _scrollViewScroll() async {
    // 当滑动到底部时，开始加载更多
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  void _loadMore() async {
    // await Future.delayed(const Duration(microseconds: 200), () {
    //   setState(() {
    //     List<String> list = List<String>.from(cityNames);
    //     list.addAll(cityNames);
    //     cityNames = list;
    //   });
    // });

    await Future.delayed(const Duration(microseconds: 200));
    setState(() {
      List<String> list = List<String>.from(cityNames);
      list.addAll(cityNames);
      cityNames = list;
    });
  }

  // 下拉刷新
  Future<void> _handleRefresh() async {
    // 延迟2秒后，执行代码块
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        cityNames = cityNames.reversed.toList();
      });
    });
    
  }
}
