import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/api/user.dart';
import 'package:hm_shop/stores/TokenManager.dart';
import 'package:hm_shop/stores/UserController.dart';
import 'package:hm_shop/utils/LoadingDialog.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _phoneController = TextEditingController(); // 账号控制器
  TextEditingController _codeController = TextEditingController(); // 密码控制器

  // 👉 因为 MainPage 已经 put 过一次，所以只能直接 find 获取 UserController
  final UserController _userController = Get.find<UserController>();

  // 用户账号Widget
  Widget _buildPhoneTextField() {
    // 👉 TextFormField 的 validator 方法返回校验文本
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "手机号不能为空";
        }
        // 👉 正则校验手机号格式
        if (!RegExp(r"^1[3-9]\d{9}$").hasMatch(value)) {
          return "手机号格式不正确";
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入账号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 用户密码Widget
  Widget _buildCodeTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "密码不能为空";
        }
        // 密码的校验 6-16位的数字 字母或下划线
        if (!RegExp(r"^[a-zA-Z0-9_]{6,16}$").hasMatch(value)) {
          return "请输入6-16位的字母数字或者下划线";
        }
        return null;
      },
      controller: _codeController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 20), // 内容内边距
        hintText: "请输入密码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  // 登录按钮Widget
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 登录逻辑
          if (_key.currentState!.validate()) {
            // 进行勾选框的判断
            if (_isChecked) {
              // 校验通过，开始登陆
              // print("--- 校验通过，开始登陆");
              _login();
              
            } else {
              // 提示请勾选用户协议
              ToastUtils.showToast(context, "请勾选用户协议");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text("登录", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  bool _isChecked = false;

  // 勾选Widget
  Widget _buildCheckbox() {
    return Row(
      children: [
        // 设置勾选为圆角
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          // 设置形状
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 圆角大小
          ),
          // 可选：设置边框
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "查看并同意"),
              TextSpan(
                text: "《隐私条款》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 头部Widget
  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
  // 测试账号：1320000000【1～9】，密码：123456
  _login() async {
    LoadingDialog.show(context, message: "努力登录中...");
    try {
      final res = await loginAPI({
        "account": _phoneController.text,
        "password": _codeController.text,
      });
      // 👉 更新 GetX 插件存储的 全局用户信息
      _userController.updateUserInfo(res);
      // 👉 使用 shared_preferences 插件本地磁盘存储 token
      tokenManager.setToken(res.token);
      LoadingDialog.hide(context);
      ToastUtils.showToast(context, "登录成功");
      Navigator.pop(context);
    } catch (e) {
      LoadingDialog.hide(context);
      ToastUtils.showToast(context, (e as DioException).message);
    }
  }

  // 👉 GlobalKey 绑定到 Form 组件，用于调用组件上的 valiate 方法
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("惠多美登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      // 👉 Form 组件包裹，可实现 TextFormField 表单校验
      body: Form(
        key: _key,
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20),
              _buildHeader(),
              SizedBox(height: 30),
              _buildPhoneTextField(),
              SizedBox(height: 20),
              _buildCodeTextField(),
              SizedBox(height: 20),
              _buildCheckbox(),
              SizedBox(height: 20),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}