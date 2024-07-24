import 'package:flutter/material.dart';

/// 登录带禁用功能的按钮
class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LoginButton(this.title, {super.key, required this.enable, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      height: 45,
      onPressed: enable ? onPressed : null,
      disabledColor: Colors.white60,
      color: Colors.orange,
      child: Text(title, style: const TextStyle(fontSize: 16, color: Colors.white),),
    );
  }
}