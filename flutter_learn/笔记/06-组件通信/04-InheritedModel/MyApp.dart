import 'package:flutter/material.dart';

import 'home_page.dart';
import 'store/user_inherited_model.dart';
import 'store/user.dart';

/// 应用入口。
///
/// 使用 StatefulWidget 维护 [User] 状态，并通过 [UserInheritedModel]
/// 将状态与更新入口注入到整个子树中。
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 应用级用户状态。
  ///
  /// 非 final 是因为每次更新都会通过 [copyWith] 替换为新实例；
  /// 私有化避免被子树直接读写，统一走 [_updateUser]。
  User _user = const User(
    name: "Tom",
    age: 18,
    isVip: false,
  );

  /// 统一的状态更新入口。
  ///
  /// [updater] 接收旧状态并返回新状态，内部调用 [setState] 触发重建。
  /// 该方法通过 [UserInheritedModel.updateUser] 注入子树，子 Widget
  /// 无需知道 [_MyAppState] 的存在。
  void _updateUser(User Function(User) updater) {
    setState(() {
      _user = updater(_user);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 将最新的 _user 与更新回调一并注入子树。
    return UserInheritedModel(
      user: _user,
      updateUser: _updateUser,
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
