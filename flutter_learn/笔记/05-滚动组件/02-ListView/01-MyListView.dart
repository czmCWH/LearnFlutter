/*
<https://docs.flutter.cn/ui/widgets/layout>
<https://api.flutter-io.cn/flutter/widgets/BoxScrollView-class.html>

---- 滚动列表

👉 1、ListView
ListView 线性排列 Widget 的可滚动的列表。

- 在 ListView 滚动轴的交叉轴方向上，其子元素必须填满 ListView。

- itemExtent 属性，表示 ListView在滚动方向上每个 item 所占的高度值。
- prototypeItem 属性，将强制子项在滚动方向上具有与其 prototypeItem 给定 Widget 相同的大小。
- itemExtent 和 prototypeItem 是互斥的，不能同时使用。

指定 itemExtent 或 prototypeItem 比让 children 确定自己的范围更有效，因为滚动机制可以利用 children 范围的预知来节省工作。例如当滚动位置急剧变化时。

ListView 有4种构造器：
  - ListView(children：)，默认构造器，一次性所有的子 Widget。适用于具有少量子项
  
  - ListView.builder ，其 itemBuilder 属性接收一个 IndexedWidgetBuilder 对象，该对象会按需构建子组件。适用于具有大量（或无限）子元素的列表。
  
  - ListView.separated：
    itemBuilder 属性，接收一个 IndexedWidgetBuilder 对象，用于按需构建子项；
    separatorBuilder 属性，接收一个 IndexedWidgetBuilder 对象，用于构建分隔符子项，分隔符子项会出现在子项之间；
    适用于具有固定数量子元素的列表；
  
  - ListView.custom，灵活的构造器，通过 childrenDelegate 参数来控制子项的创建和管理，此参数接收2种类型：
    SliverChildListDelegate，一次性创建所有子项，等价于 ListView(children：) 方式。
    SliverChildBuilderDelegate，会按需构建子项，等价于 ListView.builder 方式。

controller 属性，控制滚动偏移量，接收一个 ScrollController 对象。

默认情况下，ListView将自动填充列表的可滚动末端，以避免 MediaQuery 的填充所指示的部分障碍。若要避免这种行为，请使用 padding zero 属性进行覆盖。

👉 2、RefreshIndicator 下拉刷新/上拉加载

 */

import 'package:flutter/material.dart';

// --- ListView(children：)，构建固定个数简单列表

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {

  late final _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(listViewScroll);
  }

  void listViewScroll() {
    // 获取滚动位置信息
    final position = _scrollController.position;
    final pixels = _scrollController.offset;  // 当前滚动偏移量
    final maxScrollExtent = position.maxScrollExtent;  // 最大滚动范围
    final minScrollExtent = position.minScrollExtent;  // 最小滚动范围

    // 判断是否滚动到顶部
    if (pixels <= minScrollExtent) {
      debugPrint('--- 滚动到顶部');
    }
    
    // 判断是否滚动到底部
    if (pixels >= maxScrollExtent) {
      debugPrint('--- 滚动到底部');
    }

    // 判断是否正在滚动
    if (position.isScrollingNotifier.value) {
      debugPrint('--- 正在滚动');
    }

    // 打印所有滚动信息
    debugPrint('--- 当前位置: $pixels');
    debugPrint('--- 最大滚动范围: $maxScrollExtent');
    debugPrint('--- 最小滚动范围: $minScrollExtent');
    debugPrint('--- 滚动方向: ${_scrollController.position.userScrollDirection}');
    debugPrint('--- 视口高度: ${position.viewportDimension}');

  }
   
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          scrollDirection: Axis.vertical,   // 滚动方向
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20), // 列表内边距
          reverse: false,    // 是否颠倒list view子项的排列方向。
          physics: const ClampingScrollPhysics(),   // list view滚动的行为，例如：不允许滚动、弹簧式滚动、无偏移式滚动。
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,    // 滑动时关闭键盘
          // itemExtent: 180,   // 强制设置每个子项item在滚动方向的范围（宽度或高度）为80
          prototypeItem: Container(color: Colors.red, height: 100,),   // 强制子项item的范围与prototypeItem一样
          children: List.generate(17, (index) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              color: Colors.purple[100*(index > 8 ? index-8 : index+1)],
              height: 50,    // 如果 ListView 设置了 itemExtent 或 prototypeItem，则此 height 无效
              child: Center(
                child: Text('第${index+1}个Item', style: const TextStyle(color: Colors.yellow),),
              )
            );
          }),
        ),
        Positioned(
          top: 20,
          right: 20,
          width: 80,
          height: 80,
          child: TextButton(
            onPressed: () {
              _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
            }, 
            style: TextButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
            child: const Text('底部'),
          ),
        ),
        Positioned(
          right: 20,
          bottom: 20,
          width: 80,
          height: 80,
          child: TextButton(
            onPressed: () {
              _scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
            }, 
            style: TextButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
            ),
            child: const Text('顶部'),
          )
        ),
      ],
    );
  }
}




/*
4、ListView.custom 接受一个 SliverChildDelegate，它提供了自定义子模型的其他方面的能力。
例如，SliverChildDelegate 可以控制用于估计实际不可见的子级大小的算法。
 */
class _MyListView4 extends State<MyListView> {

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView 滚动列表'),
      ),
      body: ListView.custom(
        childrenDelegate: SliverChildListDelegate(
          const [_ListItem(title: "0"), _ListItem(title: "1"),],
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;

  const _ListItem({Key? key, required this.title}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        alignment: Alignment.center,
        child: Text('内容：$title'),
      ),
    );
  }
}