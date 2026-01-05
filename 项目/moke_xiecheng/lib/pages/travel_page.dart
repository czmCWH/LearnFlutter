import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moke_xiecheng/model/travel_tab_model.dart';
import 'package:moke_xiecheng/model/travel_category_model.dart';
import 'package:moke_xiecheng/api/travel_api.dart';
import 'package:moke_xiecheng/pages/travel_tab_page.dart';
import 'package:underline_indicator/underline_indicator.dart';


/// 旅拍页面 - 分段控制器 + 瀑布流
class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {

  List<TravelTab> tabs = [];
  TravelCategoryModel? travelCategoryModel;

  late TabController _controller;

  get _tabBar => TabBar(
    controller: _controller,
    isScrollable: true,
    labelColor: Colors.black,   // tab 的文本颜色
    indicatorSize: TabBarIndicatorSize.tab, // 指示器为 tab 的长度
    tabAlignment: TabAlignment.start,   // 从左边到右排列
    indicator: const UnderlineIndicator(    // 使用插件处理下划线
      strokeCap: StrokeCap.round, 
      borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
      insets: EdgeInsets.only(bottom: 0),
    ),
    tabs: tabs.map<Tab>((TravelTab tab) {
      return Tab(text: tab.labelName,);
    }).toList(),
  );

  get _tabBarView => TabBarView(
    controller: _controller,
    children: tabs.map((TravelTab tab) {
      return TravelTabPage(groupChanneCode: tab.groupChannelCode);
    }).toList(),
  );

  @override
  void initState() {
    super.initState();
     _controller = TabController(length: 0, vsync: this);

    TravelApi.getCategory().then((TravelCategoryModel? model) {
      // tabbar 显示数据
      _controller = TabController(length: model?.tabs.length ?? 0, vsync: this);
      setState(() {
        travelCategoryModel = model;
        tabs = model?.tabs ?? [];
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取刘海屏 Top 安全边距
    double top = MediaQuery.of(context).padding.top;
    kIsWeb
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding:  EdgeInsets.only(top: top),    // 适配刘海屏
            child: _tabBar,
          ),
          Flexible(child: _tabBarView),
        ],
      ),
    );
  }
  
  // 缓存此 Widget，避免销毁
  // @override
  // bool get wantKeepAlive => true;

}