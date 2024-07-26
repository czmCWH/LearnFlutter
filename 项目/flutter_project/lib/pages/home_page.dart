import 'package:flutter/material.dart';
import 'package:flutter_project/api/home_api.dart';
import 'package:flutter_project/api/login_api.dart';
import 'package:flutter_project/model/home_model.dart';
import 'package:flutter_project/pages/searchPage.dart';
import 'package:flutter_project/util/navigator_util.dart';
import 'package:flutter_project/util/view_util.dart';
import 'package:flutter_project/widget/banner_widget.dart';
import 'package:flutter_project/widget/grid_nav_widget.dart';
import 'package:flutter_project/widget/loading_container.dart';
import 'package:flutter_project/widget/local_nav_widget.dart';
import 'package:flutter_project/widget/sales_box_widget.dart';
import 'package:flutter_project/widget/sub_nav_widget.dart';
import 'package:flutter_project/widget/search_bar_widget.dart';

const searchBarDefaultText = '网红打卡地 景点 酒店 美食';

class HomePage extends StatefulWidget {

  static Config? configModel;

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  static const appBarScrollOffset = 100.0;
  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;

  bool _loading = true;

  get _logoutBtn => TextButton(
    onPressed: () {
      LoginDao.logOut();
    }, 
    child: const Text('登出', style: TextStyle(color: Colors.white),),
  );


  // get _appBar => Opacity(
  //   opacity: appBarAlpha,
  //   child: Container(
  //     padding: const EdgeInsets.only(top: 20),
  //     height: 80,
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //     ),
  //     child: const Center(child: 
  //       Padding(
  //         padding: EdgeInsets.only(top: 20), 
  //         child: Text('首页', style: TextStyle(color: Colors.black),),  
  //       ),
  //     ),
  //   ),
  // );

  get _appBar {
    // 获取刘海屏安全边距
    double top = MediaQuery.of(context).padding.top;

    return Column(
      children: [
        shadowWrap(
          child: Container(
            padding: EdgeInsets.only(top: top),
            height: 60 + top,
            decoration: BoxDecoration(
              color: Color.fromARGB((appBarAlpha*255).toInt(), 255, 255, 255),
            ),
            child: SearchBarWidget(
              searchBarType: appBarAlpha > 0.2 ? SearchBarType.homeLight : SearchBarType.home,
              defaultText: searchBarDefaultText,
              inputBoxClick: _jumpToSearch,
              rightButtonClick: () {
                LoginDao.logOut();
              },
            ),
          ),
        ),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5),]
          ),
        ),
      ],
    );
  }

  get _listView => ListView(
    children: [
      BannerWidget(bannerList: bannerList),
      LocalNavWidget(localNavList: localNavList),
      if (gridNavModel != null) GridNavWidget(gridNavModel: gridNavModel!),
      SubNavWidget(subNavList: subNavList,),
      if (salesBoxModel != null) SalesBoxWidget(salesBox: salesBoxModel!),
      const SizedBox(height: 600,),
    ],
  );
  
  get _contentView => MediaQuery.removePadding(
    removeTop: true,  // 移除 ListView 自带顶部刘海的 padding
    context: context, 
    child: RefreshIndicator(  // 下拉刷新
      color: Colors.blue,
      onRefresh: _handleRefresh,
      child: NotificationListener( // 添加滚动监听
      onNotification: (scrollNotification) {
          // 只监听最外层 Widget 的滚动
          if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
            _onScroll(scrollNotification.metrics.pixels);
          }
          return false;
        },
        child: _listView,
      ),
    ),
  );


  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // LoadingContainer

    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _loading,
        child: Stack(
          children: [_contentView, _appBar,],
        ),
      ),
    );
  }

  // 缓存此 Widget，避免销毁
  @override
  bool get wantKeepAlive => true;

  // 监听列表滚动
  void _onScroll(double offY) {
    double alpha = offY / _HomePageState.appBarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    debugPrint('--- offSet: $offY, alpha: $alpha');
  }

  /// 获取首页数据
  Future<void> _handleRefresh() async {
    try {
      HomeModel? model = await HomeApi.fetch();
      if (model == null) {
        setState(() {
          _loading = false;
        });
        return;
      }
      setState(() {
        HomePage.configModel = model.config;
        localNavList = model.localNavList ?? [];
        subNavList = model.subNavList ?? [];
        gridNavModel = model.gridNav;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList ?? [];
         
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      debugPrint('--- error = $e');
    }

  }

  void _jumpToSearch() {
    NavigatorUtil.push(context, const SearchPage(hideLeft: false,));
  }

} 