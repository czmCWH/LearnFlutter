import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main_scaffold.dart';
import '../screen/a_screen.dart';
import '../screen/b_screen.dart';
import '../screen/c_screen.dart';
import '../screen/d_screen.dart';
import '../screen/detail.dart';
import '../screen/A/index.dart';
import '../screen/C/index.dart';
import '../main_controller.dart';

part 'app_routes.dart';

class AppPages {

  static final routes = [
    GetPage(
      name: Routes.root,    // 路由名称
      page: () => const MainScaffold(),   // 路由构建函数
      // maintainState: true,  // 是否保持页面状态， 防止页面重建
      // participatesInRootNavigator: true,  // 控制页面在导航器层次结构中的行为。为 true，页面将参与根导航器；为 false，页面将参与子导航器
      // 这里的 binding 确保进入主页时控制器已就绪
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MainController());
      }),
      children: [
        GetPage(
          name: Routes.one, 
          page: () => const AOneScreen(),
          title: "GetPage title A-One-页面",
        ),
        GetPage(
          name: Routes.two,
          page: () => const ATwoScreen(),
          transition: Transition.downToUp,
        ),
        GetPage(
          name: Routes.three,
          page: () => const AThreeScreen(),
          transition: Transition.zoom,
        ),
        GetPage(
          name: Routes.four,
          page: () => const AFourScreen(),
        ),

        GetPage(
          name: Routes.cOne, 
          page: () => COneScreen(),
          title: "C-One-页面",
        ),
        GetPage(
          name: Routes.cTwo, 
          page: () => CTwoScreen(),
          title: "C-Two-页面",
          children: [
            GetPage(
              name: Routes.detail, 
              page: () => CTwoDetailScreen(),
              title: "C-Two-Detail-页面",
            ),
          ]
        ),
        GetPage(
          name: Routes.cThree, 
          page: () => CThreeScreen(),
          title: "C-Three-页面",
        ),
        
      ]
    ),

    // GetPage(
    //   name: Routes.A, 
    //   page: () => const SizedBox.shrink(), // 创建空白页面
    //   transition: Transition.noTransition,
    //   opaque: false,    // 让页面显示透明
    // ),
    // GetPage(
    //   name: Routes.B, 
    //   page: () => const SizedBox.shrink(), // 创建空白页面
    //   transition: Transition.noTransition,
    //   opaque: false,    // 让页面显示透明
    // ),
    // GetPage(
    //   name: Routes.C, 
    //   page: () => const SizedBox.shrink(), // 创建空白页面
    //   transition: Transition.noTransition,
    //   opaque: false,    // 让页面显示透明
    // ),
    // GetPage(
    //   name: Routes.D, 
    //   page: () => const SizedBox.shrink(), // 创建空白页面
    //   transition: Transition.noTransition,
    //   opaque: false,    // 让页面显示透明
    // ),
  ];

  // static void toNamed(String routeName, {int? tabIndex}) {
  //   if (routeName == '/' && tabIndex != null) {
  //     Get.offAllNamed(Routes.root);   // 回到根路由
  //     Get.find<MainController>().changeTabIndex(tabIndex);    // 切换 tabbar
  //   } else {
  //     Get.toNamed(routeName);
  //   }
  // }
}