import 'package:flutter/material.dart';
import '../store/user_inherited_model.dart';
import '../store/user_aspect.dart';

/// 展示用户 VIP 状态的 Widget。
///
/// 通过 [UserInheritedModel.of] 并指定 [UserAspect.vip]，
/// 只订阅 isVip 字段的变化，因此当 name 或 age 变化时不会重建。
class VipWidget extends StatelessWidget {
  const VipWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 打印日志仅用于验证局部刷新：
    // 点击“修改姓名”或“修改年龄”时，此行不应输出。
    debugPrint("----- Vip Widget build");

    final user = UserInheritedModel.of(
      context,
      aspect: UserAspect.vip,
    );

    return Text(
      "VIP：${user.isVip ? '是' : '否'}",
      style: const TextStyle(fontSize: 22),
    );
  }
}
