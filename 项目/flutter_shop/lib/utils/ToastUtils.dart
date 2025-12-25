import 'package:flutter/material.dart';

/// 通过 SnackBar 封装提示消息组件
class ToastUtils {
  
  // 阀门控制，保证有 toast 显示时，不允许 toast
  static bool showLoading = false;

  static void showToast(BuildContext context, String? msg) {
    if (ToastUtils.showLoading) {
      return;
    }
    ToastUtils.showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      ToastUtils.showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)
            // borderRadius: BorderRadiusGeometry.circular(40),
            ),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
        content: Text(msg ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
