import 'package:flutter/material.dart';
import 'js2Flutter_by_url.dart';
import 'js2Flutter_by_channel.dart';
import 'flutter2js_by_url.dart';
import 'flutter2js_by_runjs.dart';
import '../03-Flutter加载h5的其它方式/flutter_h5_jump_asset.dart';
import '../03-Flutter加载h5的其它方式/flutter_h5_jump_file.dart';
import '../03-Flutter与h5登录状态同步/flutter_h5_sync_by_cookie.dart';
import '../03-Flutter与h5登录状态同步/flutter_h5_sync_by_channel.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 一个 Material App 从 MaterialApp widget 开始
    return const MaterialApp(
      // 设置 / route 
      home: MyHomePage(),
      // 禁止显示调试横幅
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('首页'),),
      body: Center(
        child: Column(
          children: <Widget>[
            _navButton(context, const Js2flutterByUrl(), 'H5 通过 URL 向 Flutter 传递数据'),
            _navButton(context, const Js2flutterByChannel(), 'H5 通过 javaScriptChannels 向 Flutter 传递参数'),
            _navButton(context, const Flutter2jsByUrl(), 'Flutter 通过 URL 向 H5 传递数据'),
            _navButton(context, const Flutter2jsByRunjs(), 'Flutter 通过 run Js 向 H5 传递数据'),
            
            const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 15), child: Text('根据静态资源加载H5'),),

            _navButton(context, const FlutterH5AssetJump(), '通过 loadFlutterAsset 的方式加载 H5'),
            _navButton(context, const FlutterH5JumpFile(), '通过 loadFile 的方式加载 H5'),

            const Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 15), child: Text('同步初始状态到H5'),),
            _navButton(context, const FlutterH5LoginCookie(), 'Flutter 通过 cookie 的方式将登录状态同步给h5'),
            _navButton(context, const FlutterH5LoginChannel(), 'Flutter 通过 channel 的方式将登录状态同步给h5'),
            
          ],
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, Widget page, String title) {
    return FilledButton(
      onPressed: () {
        debugPrint('--- 点击路由');
        Navigator.push(context, MaterialPageRoute<String>(builder: (BuildContext context) {
            return page;
          }),  
        );
      }, 
      child: Text(title),
    );
  }
}

