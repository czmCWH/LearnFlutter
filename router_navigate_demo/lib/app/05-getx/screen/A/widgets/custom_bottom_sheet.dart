import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet {
  /// 显示底部选择器
  /// [items] 外部传入的选项文字列表
  /// [onSelected] 点击回调，返回选中的索引和文字
  static Future<void> show({
    required List<String> items,
    Function(int index, String value)? onSelected,
    String cancelText = "取消",
  }) {
    return Get.bottomSheet(
      Container(
        // 1. 顶部圆角为 20 (根据需求设定，此处实现圆角 16 或 20 均可)
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min, // 高度自适应内容
            children: [
              const SizedBox(height: 8),
              // 1. 选择器列表内容从外部传入
              ...items.asMap().entries.map((entry) {
                int index = entry.key;
                String val = entry.value;
                return ListTile(
                  title: Text(val, textAlign: TextAlign.center),
                  onTap: () {
                    // 2. 点击选择item后，通知弹出层并关闭
                    Get.back(); 
                    onSelected?.call(index, val);
                  },
                );
              }).toList(),
              
              // 分割线
              const Divider(height: 1, thickness: 1),
              
              // 1. 最后一个 item 为取消
              ListTile(
                title: Text(
                  cancelText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onTap: () => Get.back(), // 直接关闭
              ),
            ],
          ),
        ),
      ),
      // 样式配置
      backgroundColor: Colors.transparent,
      isScrollControlled: false, // 如果内容极多，可设为 true
    );
  }
}
