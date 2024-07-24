import 'package:flutter/material.dart';
import 'package:flutter_project/api/login_api.dart';
import 'package:flutter_project/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  final bannerList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];
  static const appBarScrollOffset = 100.0;
  double appBarAlpha = 0;

  get _logoutBtn => TextButton(
    onPressed: () {
      LoginDao.logOut();
    }, 
    child: const Text('登出', style: TextStyle(color: Colors.white),),
  );

  get _appBar => Opacity(
    opacity: appBarAlpha,
    child: Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: const Center(child: 
        Padding(
          padding: EdgeInsets.only(top: 20), 
          child: Text('首页', style: TextStyle(color: Colors.black),),  
        ),
      ),
    ),
  );

  get _listView => ListView(
    children: [
      BannerWidget(bannerList: bannerList),
      const SizedBox(height: 600,),
    ],
  );
  
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: Stack(
        children: [
          // 移除 ListView 自带顶部刘海的 padding
          MediaQuery.removePadding(removeTop: true, context: context, child: 
            // 添加滚动监听
            NotificationListener(
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
          _appBar,
        ],
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

}