import 'package:flutter/material.dart';
import '../store/user_inherited_model.dart';
import '../store/user_aspect.dart';


/// 展示用户姓名的 Widget。
///
/// 通过 [UserInheritedModel.of] 并指定 [UserAspect.name]，
/// 只订阅 name 字段的变化，因此当 age 或 vip 变化时不会重建。
class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 打印日志仅用于验证局部刷新：
    // 点击“修改年龄”或“修改VIP”时，此行不应输出。
    debugPrint("----- Name Widget build");

    final user = UserInheritedModel.of(
      context,
      aspect: UserAspect.name,
    );

    return Text(
      "姓名：${user.name}",
      style: const TextStyle(fontSize: 22),
    );
  }
}
