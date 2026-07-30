import 'package:flutter/material.dart';
import '../store/user_inherited_model.dart';
import '../store/user_aspect.dart';

/// 展示用户年龄的 Widget。
///
/// 通过 [UserInheritedModel.of] 并指定 [UserAspect.age]，
/// 只订阅 age 字段的变化，因此当 name 或 vip 变化时不会重建。
class AgeWidget extends StatelessWidget {
  const AgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 打印日志仅用于验证局部刷新：
    // 点击“修改姓名”或“修改VIP”时，此行不应输出。
    debugPrint("----- Age Widget build");

    final user = UserInheritedModel.of(
      context,
      aspect: UserAspect.age,
    );

    return Text(
      "年龄：${user.age}",
      style: const TextStyle(fontSize: 22),
    );
  }
}
