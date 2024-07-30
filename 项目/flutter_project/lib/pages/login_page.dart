import 'package:flutter/material.dart';
import 'package:flutter_project/util/navigator_util.dart';
import 'package:flutter_project/util/string_util.dart';
import 'package:flutter_project/util/view_util.dart';
import 'package:flutter_project/widget/input_widget.dart';
import 'package:flutter_project/widget/login_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_project/api/login_api.dart';

/// 登录页
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  String? userName;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,    // 防止键盘弹起影响布局
      body: Stack(
        children: [
          ..._background(),
          _content(),

        ],
      ),
    );
  }

  // 创建背景
  _background() {
    return [
      Positioned.fill(    // 让子项填充满父项
        child: Image.asset('images/login-bg1.jpg', fit: BoxFit.cover,),   // 设置背景图
      ),
      Positioned.fill(  // 设置蒙层
        child: Container(decoration: const BoxDecoration(color: Colors.black38),) 
      ),  
    ];
  }

  // 创建内容
  _content() {
    return Positioned.fill(
      left: 25,
      right: 25,
      child: ListView(
        children: [
          hiSpace(height: 100),
          const Text('账号密码登录', style: TextStyle(fontSize: 26, color: Colors.white,),),
          hiSpace(height: 40),
          InputWidget(
            '请输入账号', 
            onChanged: (text) {
              userName = text;
              _checkInput();
            }
          ),
          hiSpace(height: 10),
          InputWidget(
            '请输入密码', 
            obscureText: true,
            onChanged: (text) {
              password = text;
              _checkInput();
            }
          ),
          hiSpace(height: 45),
          LoginButton('登录', enable: loginEnable, onPressed: () => _login(context),),
          hiSpace(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => _jumpRegister(),
              child: const Text('注册账号', style: TextStyle(fontSize: 14, color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
  
  // 输入框内容检查，控制登录按钮是否可点击
  _checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }
  

  _login(context) async {
    // 账号：cboy56，密码：123
    debugPrint('-- 点击登录按钮');
    try {
      var result = await LoginDao.login(userName: userName!, password: password!);
      debugPrint('--- 登录成功 $result');
    } catch (e) {
      debugPrint('--- 登录失败 $e');
    }
    NavigatorUtil.goToHome(context);
  }

  /// 点击注册
  _jumpRegister() async {
    // 使用 url_launcher 插件打开网页地址
    Uri uri = Uri.parse('https://api.devio.org/uapi/swagger-ui.html#/Account/registrationUsingPOST');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw '无法打开链接 $uri';
    }
  }

}