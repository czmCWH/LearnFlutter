/// user_model.dart

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'user.dart';
import 'user_aspect.dart';

/// 用于向子树共享 [User] 状态，并按 [UserAspect] 实现局部刷新。
///
/// 继承 [InheritedModel<T>]，其中泛型 [T] 代表“切面（aspect）”类型。
/// 子 Widget 通过 [of] 注册自己关心的 aspect；当对应 aspect 的数据
/// 发生变化时，只有订阅了该 aspect 的 Widget 才会重建。
class UserInheritedModel extends InheritedModel<UserAspect> {
  /// 当前共享的用户状态。
  final User user;

  /// 状态更新回调，由上层 State 注入。
  ///
  /// 子树不直接访问祖先 State，而是通过 [update] 方法间接调用此回调，
  /// 从而降低耦合，避免使用 [findAncestorStateOfType] 等反模式。
  final void Function(User Function(User) updater) updateUser;

  const UserInheritedModel({
    super.key,
    required this.user,
    required this.updateUser,
    required super.child,
  });

  /// 读取 [User] 数据，并按 [aspect] 建立依赖关系。
  ///
  /// - 传入 [aspect]：仅当该 aspect 对应的字段变化时，当前 Widget 才会重建。
  /// - 不传 [aspect]（值为 null）：订阅所有 aspect 的变化，任何字段变化都会重建。
  ///
  /// 注意：调用此方法会让当前 Widget 与 InheritedModel 产生依赖，
  /// 因此只能在 [build] 方法内部或其后代调用。
  static User of(BuildContext context, {UserAspect? aspect}) {
    final model = InheritedModel.inheritFrom<UserInheritedModel>(
      context,
      aspect: aspect,
    );
    return (model ?? _notFound()).user;
  }

  /// 触发状态更新。
  ///
  /// 使用 [BuildContext.getElementForInheritedWidgetOfExactType] 查找 model，
  /// 该方法不会建立依赖关系，因此适合在事件回调（如按钮点击）中调用，
  /// 避免事件源 Widget 被不必要的重建。
  ///
  /// [updater] 接收当前 [User] 并返回新的 [User]，通常配合 [User.copyWith] 使用。
  static void update(BuildContext context, User Function(User) updater) {
    final element =
        context.getElementForInheritedWidgetOfExactType<UserInheritedModel>();
    if (element == null) {
      throw FlutterError(
        '在当前 context 上方找不到 UserInheritedModel，无法更新状态。\n'
        '请确保该 Widget 已被 UserInheritedModel 包裹。',
      );
    }
    final model = element.widget as UserInheritedModel;
    model.updateUser(updater);
  }

  static UserInheritedModel _notFound() {
    throw FlutterError(
      '在当前 context 上方找不到 UserInheritedModel。\n'
      '请确保该 Widget 已被 UserInheritedModel 包裹。',
    );
  }

  /// 决定是否要进入下一步的局部通知判断。
  ///
  /// 只要 [user] 的内容发生变化就返回 true；返回 true 后，框架会进一步调用
  /// [updateShouldNotifyDependent] 判断哪些 aspect 的依赖项需要重建。
  @override
  bool updateShouldNotify(UserInheritedModel oldWidget) {
    return user != oldWidget.user;
  }

  /// 局部刷新的核心逻辑。
  ///
  /// [dependencies] 是当前 Widget 订阅的 aspect 集合。
  /// 只有当某个订阅的 aspect 对应的数据真正发生变化时，才返回 true，
  /// 从而触发该 Widget 重建；否则跳过，避免无效刷新。
  @override
  bool updateShouldNotifyDependent(
    UserInheritedModel oldWidget,
    Set<UserAspect> dependencies,
  ) {
    if (dependencies.contains(UserAspect.name) &&
        user.name != oldWidget.user.name) {
      return true;
    }
    if (dependencies.contains(UserAspect.age) &&
        user.age != oldWidget.user.age) {
      return true;
    }
    if (dependencies.contains(UserAspect.vip) &&
        user.isVip != oldWidget.user.isVip) {
      return true;
    }
    return false;
  }
}
