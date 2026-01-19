import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static Future<T?> show<T>({
    required String title,
    required String content,
    String cancelText = "取消",
    String confirmText = "确定",
    VoidCallback? onCancel,
    VoidCallback? onConfirm,
  }) {
    return Get.dialog<T>(
      // 1. 弹窗居中
      Center(
        child: Material(
          color: Colors.transparent, // 避免背景干扰
          child: Container(
            width: 300, // 宽度占屏幕80%
            padding: const EdgeInsets.all(20),
            // 1. 背景白色，圆角16
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 高度自适应内容
              children: [
                // 2. 标题文本
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                // 2. 内容文本
                Text(
                  content,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // 2. 底部左右水平按钮
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Get.back(result: false); // 关闭弹窗，回传 false
                          onCancel?.call();
                        },
                        child: Text(cancelText, style: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Get.back(result: true); // 关闭弹窗，回传 true
                          onConfirm?.call();
                        },
                        child: Text(confirmText, style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // 1. 蒙板颜色为 0.4 透明度的黑色
      barrierColor: Colors.black.withOpacity(0.4), 
      barrierDismissible: true, // 点击背景是否可以关闭
    );
  }
}
