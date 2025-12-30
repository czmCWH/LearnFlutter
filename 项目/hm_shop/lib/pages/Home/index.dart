import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/ShCategory.dart';
import 'package:hm_shop/components/Home/ShHot.dart';
import 'package:hm_shop/components/Home/ShMoreList.dart';
import 'package:hm_shop/components/Home/ShSlider.dart';
import 'package:hm_shop/components/Home/ShSuggestion.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

/*
  首页功能点：
    下拉刷新；
    封装提示消息；
    GlobalKey 调用 Widget 自身的方法；

 */

class HomView extends StatefulWidget {
  const HomView({super.key});

  @override
  State<HomView> createState() => _HomViewState();
}

class _HomViewState extends State<HomView> {

  // 👉 数据
  // 轮播图数据
  List<BannerItem> _bannerList = [];
  // 分类列表
  List<CategoryItem> _categoryList = [];
  // 特惠推荐
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 热榜推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

   // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 👉 滚动容器内容组件
  List<Widget> _getScrollChildren() {
    return [
      // 1、轮播图
      SliverToBoxAdapter(child: ShSlider(bannerList: _bannerList,),),
      
      SliverToBoxAdapter(child: SizedBox(height: 10,),),

      // SliverGrid、SliverList 只能纵向滚动，因此横向滚动只能用 ListView
      
      // 2、分类横向滚动组件
      SliverToBoxAdapter(
        child: ShCategory(categoryList: _categoryList,),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),

      // 3、推荐组件
      SliverToBoxAdapter(
        child: ShSuggestion(specialRecommendResult: _specialRecommendResult),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),

      // 4、爆款组件
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(child: ShHot(result: _inVogueResult, type: "hot",)), 
              SizedBox(width: 10,), 
              Expanded(child: ShHot(result: _oneStopResult, type: "step",)),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10,),),

      // 5、无限滚动列表
      ShMoreList(recommendList: _recommendList)
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 👉 初始化数据，更新UI状态
    // _getBannerList();
    // _getCategoryList();
    // _getProductList();
    // _getInVogueList();
    // _getOneStopList();
    // _getRecommendList();

    // 通过 GlobalKey 直接操作 Widget 的方法。
    // 由于 initState 在 build 方法之前执行，所以此时无法通过 GlobalKey 获取 Widget
    // 因此需要通过 微任务 来获取
    Future.microtask(() {
      setState(() {
        _paddingTop = 100;  
      });
      _key.currentState?.show();
    });

    // 注册事件
    _registerEvent();
  }

  void _registerEvent() {
    // 监听滚动
    _controller.addListener(() {
       // 👉 距离底部小于50距离时，触发上拉加载更多
      if (_controller.position.pixels >= (_controller.position.maxScrollExtent - 50)) {
        _getRecommendList();
        setState(() {
          
        });
      }
      
    });
  }

  // 获取轮播列表数据
  Future<void> _getBannerList() async {
   _bannerList = await getBannerListAPI();
  }

  // 获取分类列表数据
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  // 获取特惠推荐
  Future<void> _getProductList() async {
    _specialRecommendResult = await getProductListAPI();
  }

  // 获取爆款推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  // 页码
  int _page = 1;
  // 当前是否在加载
  bool _isLoading = false;
  // 是否还有下一页，true 有下一页；false 没有下一页；
  bool _hasMore = true;  

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    // 当有请求 或者 没有下一页，则不允许加载
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;  // 开始加载
    int requestLimit = _page * 10;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false; // 加载结束
    if (_recommendList.length < requestLimit) {
      // 请求 requestLimit 条，返回比它少，则没有下一页
      _hasMore = false;
      return;
    }
    _page++;
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;

    await _getBannerList();
    await _getCategoryList();
    await _getProductList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();

    // 下拉刷新数据成功
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     width: 120,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadiusGeometry.circular(40),
    //     ),
    //     behavior: SnackBarBehavior.floating,
    //     duration: Duration(seconds: 3),
    //     content: Text("刷新成功！", textAlign: TextAlign.center,),
    //   )
    // );
    _paddingTop = 0;  
    setState(() {
    });
    ToastUtils.showToast(context, "刷新成功！");
  }

  // 滚动控制器
  final ScrollController _controller = ScrollController();

  //  👉 GlobalKey 是一个方法，它可以创建一个key绑定到Widget部件上，从而可以操作对应的 Widget
  // 定义一个 Key 绑定到 RefreshIndicator 下拉刷新组件
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();

  // 下拉刷新时，页面下滑偏移距离
  double _paddingTop = 0;

  @override
  Widget build(BuildContext context) {
    // RefreshIndicator 下拉刷新组件
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      //  👉 AnimatedContainer 组件，用于实现下拉刷新时，主页面整体下滑滑动动画
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 500),
        child: CustomScrollView(
          controller: _controller,  // 绑定控制器，监听滚动
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}