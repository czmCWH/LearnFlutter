import 'package:flutter/material.dart';
import 'package:flutter_shop/api/user.dart';
import 'package:flutter_shop/pages/Cart/index.dart';
import 'package:flutter_shop/pages/Category/index.dart';
import 'package:flutter_shop/pages/Home/index.dart';
import 'package:flutter_shop/pages/Mine/index.dart';
import 'package:flutter_shop/stores/TokenManager.dart';
import 'package:flutter_shop/stores/UserController.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // 定义标签栏数据，根据数据进行渲染底部4个导航
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "title": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "title": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "title": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "title": "我的",
    },
  ];

  int _currentIndex = 0;

  // 返回标签栏底部4个item
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30,),
        activeIcon: Image.asset(_tabList[index]["active_icon"]!, width: 30, height: 30,),
        label: _tabList[index]["title"]!
      );
    });
  }

  // 
  List<Widget> _getChildren() {
    return [
      HomView(),
      CategoryView(),
      CartView(),
      MineView()
    ];
  }

  // 👉 Getx 仅 put 一次，全局状态
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 初始化用户信息
    _initUser();
  }

  void _initUser() async {
    // 👉 必须初始化 token 
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      // 如果 token 有值，则获取用户信息
      final data = await getUserInfoAPI();
      _userController.updateUserInfo(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: IndexedStack(
      //     index: _currentIndex,
      //     children: _getChildren(),
      //   ),
      // ),
      // 去掉 SafeArea， 使得页面内容沉浸到状态栏下
      body: IndexedStack(
        index: _currentIndex,
        children: _getChildren(),
      ),
      bottomNavigationBar: BottomNavigationBar(   // 底部标签栏
        onTap: (value) {
          // 点击 TabItem 的回调
          setState(() {
            _currentIndex = value;
          });
        },
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,

      ),
    );
  }
}