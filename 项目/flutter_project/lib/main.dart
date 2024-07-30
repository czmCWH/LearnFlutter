import 'package:flutter/material.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:flutter_project/api/login_api.dart';
import 'package:flutter_project/navigator/tab_navigator.dart';
import 'package:flutter_project/util/screen_adapter_helper.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter学习',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: FutureBuilder(
        future: _doInit(), 
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          // 初始化屏幕适配工具
          ScreenHelper.init(context);
          
          if (snapshot.connectionState == ConnectionState.done) {
            if (LoginDao.getBoardingPass() == null) {
              return const LoginPage();
            } else  {
              return const TabNavigator();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
      ),
    );
  }

  Future<void> _doInit() async {
    // 预初始化缓存工具
    await HiCache.preInit(); 

    Future.delayed(const Duration(milliseconds: 500), () {
      // 通过 flutter_splash_screen 插件 处理关闭 Android 端对应的启动屏幕
      
    });
  }

}
