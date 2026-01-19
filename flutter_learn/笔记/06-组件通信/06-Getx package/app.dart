import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './routes/app_pages.dart';
import './screen/UnknownRoutePage.dart';
import './screen/C/binding/AllControllerBinding.dart';
import './screen/D/language.dart';

/*
 1、Getx 的使用
  GetMaterialApp，是使用 Getx 的第一步，此组件作为App的顶层组件。

  <https://github.com/jonataslaw/getx/blob/master/documentation/zh_CN/route_management.md>，Getx路由管理官方文档
  <https://github.com/penghero/flutter_ducafecat_news_getx-master>，猫哥getx新闻示例
  <https://www.cnblogs.com/linuxAndMcu/p/18473671>，Flutter插件Get（3）：路由管理篇
  <https://www.bilibili.com/video/BV17m4y1a7zJ>, B站 Getx教程_Flutter+Getx系列实战教程

  Getx 是一个微框架，主要功能有：路由管理、状态管理、依赖管理、主题管理、国际化、数据验证等功能。

 */

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // ⚠️ GetMaterialApp，是使用 Getx 的第一步，此组件作为App的顶层组件。
    // 如果要在没有 context 的情况下使用路由/Snackbar/对话框/底部表单，或者使用高级 Get API，则只需在 MaterialApp 前面添加“Get”，将其变为 GetMaterialApp 即可！
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Getx 路由管理',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(centerTitle: true,),
      ),
      
      translations: Messages(),   // 配置语言包
      locale: const Locale("zh", "CN"),   // 配置默认加载的语言为中文
      fallbackLocale: const Locale("en", "US"),   // 添加备选语言
      
      initialRoute: "/",    // 根路由
      unknownRoute: GetPage(name: '/notfound', page: () => UnknownRoutePage()), // 匹配 /notfound 路由，用于处理导航到未定义路由（404 错误）的情况
      getPages: AppPages.routes,   // 定义路由页面
      defaultTransition: Transition.rightToLeft,    // 默认路由转场动画
      routingCallback: (Routing? value) {
        debugPrint("--- routingCallback = ${value?.current}");
      },
      
      initialBinding: AllControllerBinding(),   // ⚠️，全局绑定 GetxController
    );
  }
}