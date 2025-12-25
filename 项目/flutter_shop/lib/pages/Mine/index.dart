import 'package:flutter/material.dart';
import 'package:flutter_shop/api/mine.dart';
import 'package:flutter_shop/components/Home/ShMoreList.dart';
import 'package:flutter_shop/components/Mine/ShGuess.dart';
import 'package:flutter_shop/stores/TokenManager.dart';
import 'package:flutter_shop/stores/UserController.dart';
import 'package:flutter_shop/viewmodels/home.dart';
import 'package:flutter_shop/viewmodels/user.dart';
import 'package:get/get.dart';

class MineView extends StatefulWidget {
  const MineView({super.key});

  @override
  State<MineView> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {

  // 👉 MainPage 中put过了，此处只能 find
  final UserController _userController = Get.find<UserController>();

  // 退出登录组件
  Widget _getLogout() {
    return _userController.user.value.id.isNotEmpty ? Expanded(child: GestureDetector(
      onTap: () {
        // 弹出提示框
        showDialog(
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text("提示"),
              content: Text("确认退出登录吗？"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  child: Text("取消")
                ),
                TextButton(
                  onPressed: () {
                    // 删除 token
                    tokenManager.removeToken();
                    // 清除 Getx
                    _userController.updateUserInfo(UserInfo.fromJSON({}));
                    Navigator.pop(context);
                  }, 
                  child: Text("确认")
                ),
              ]
            );
          }
        );
      },
      child: Text("退出登录", textAlign: TextAlign.end,),
    )) : Text("");
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFFFF2E8), const Color(0xFFFDF6F1)],
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 40, top: 80, bottom: 20),
      child: Row(
        children: [
          Obx(() {
            return CircleAvatar(
              radius: 26,
              backgroundImage: _userController.user.value.avatar.isNotEmpty ? NetworkImage(_userController.user.value.avatar) : AssetImage('lib/assets/goods_avatar.png'),
              backgroundColor: Colors.white,
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 在 Widget 树中使用 Getx 必须使用 Obx 包裹
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      if (_userController.user.value.id.isEmpty) {
                        Navigator.pushNamed(context, "/login");
                      }
                    },
                    child: Text( 
                      _userController.user.value.id.isNotEmpty ? _userController.user.value.account : '立即登录', 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600,)
                    ),
                  );
                }),
              ],
            ),
          ),
          Obx(() => _getLogout()),
        ],
      ),
    );
  }

  Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 197, 153),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/ic_user_vip.png", width: 30, height: 30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '升级美荟商城会员，尊享无限免邮',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(128, 44, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('立即开通', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/ic_user_collect.png", '我的收藏'),
            item("lib/assets/ic_user_history.png", '我的足迹'),
            item("lib/assets/ic_user_unevaluated.png", '我的客服'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderModule() {
    // 内部函数
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '我的订单',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  orderItem("lib/assets/ic_user_order.png", '全部订单'),
                  orderItem("lib/assets/ic_user_obligation.png", '待付款'),
                  orderItem("lib/assets/ic_user_unreceived.png", '待发货'),
                  orderItem("lib/assets/ic_user_unshipped.png", '待收货'),
                  orderItem("lib/assets/ic_user_unevaluated.png", '待评价'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final ScrollController _controller = ScrollController();

  List<GoodDetailItem> _list = [];
  Map<String, dynamic> _params = { "page": 1, "pageSize": 10 };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getGuessList();

    _registerEvent();
  }

  Future<void> _getGuessList() async {
    if (_isLoading || !_hasMore) {
      return;
    }
    _isLoading = true;
    final res = await getGuessListAPI(_params);
    setState(() {
      _list.addAll(res.items);  // 追加内容
    });
     _isLoading = false;
     if (_params["page"] >= res.pages) {
      _hasMore = false;
      return;
     }
    _params["page"]++;

  } 

  // 滚动阀门控制
  // 是否正在加载，true：是；false：没有加载
  bool _isLoading = false;
  // 是否有更多数据，true 是；false 没有更多数据
  bool _hasMore = true;

  void _registerEvent() {
    _controller.addListener(() {
      // 监听滚动到底部，执行加载更多
      if (_controller.position.pixels <= (_controller.position.maxScrollExtent - 50)) {
        _getGuessList();
      }
    });
  }

  
  @override
  Widget build(BuildContext context) {

    // CustomScrollView 自定义滚动容器
    return CustomScrollView(
      controller: _controller,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(),),
        SliverToBoxAdapter(child: _buildVipCard(),),
        SliverToBoxAdapter(child: _buildQuickActions(),),
        SliverToBoxAdapter(child: _buildOrderModule(),),

        // 猜你喜欢 滚动吸顶组件
        SliverPersistentHeader(delegate: ShGuess(), pinned: true,),

        // 列表，需要上拉加载更多
        ShMoreList(recommendList: _list),
      ],
    );
  }
}