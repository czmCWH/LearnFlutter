import 'package:flutter/material.dart';

/// 登录输入框，自定义Widget
class InputWidget extends StatelessWidget {
  // 占位文本
  final String hint;
  // 输入内容改变回调
  final ValueChanged<String>? onChanged;
  // 是否秘文显示
  final bool obscureText;
  final TextInputType? keyboardType;

  const InputWidget(this.hint, {super.key, required this.onChanged, this.obscureText = false, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        const Divider(color: Colors.white, height: 1, thickness: 0.5,),
      ],
    );
  }

  _input() {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofocus: !obscureText,    // 不以秘文展示，则让它自动获取焦点
      cursorColor: Colors.white,  // 光标颜色
      style: const TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w400),
      decoration: InputDecoration(  // 输入框的样式
        border: InputBorder.none,
        hintText: hint,   // 提示文案
        hintStyle: const TextStyle(fontSize: 17, color: Colors.grey),
      ),
    );
  }
}