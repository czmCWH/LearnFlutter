import 'package:flutter/foundation.dart';

/// 用户数据模型
///
/// 使用 @immutable 标注该类为不可变对象，所有字段均为 final。
/// 状态变更必须通过 [copyWith] 生成新实例，确保 InheritedModel
/// 可以基于值比较判断是否需要通知依赖项。
@immutable
class User {
  final String name;
  final int age;
  final bool isVip;

  const User({
    required this.name,
    required this.age,
    required this.isVip,
  });

  /// 基于当前对象生成一份新数据，未传入的参数保持原值。
  /// 状态管理要求“不可变数据”，因此所有更新都应走此方法。
  User copyWith({
    String? name,
    int? age,
    bool? isVip,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      isVip: isVip ?? this.isVip,
    );
  }

  /// 重写值相等，使 InheritedModel 的 [updateShouldNotify] 按内容比较。
  /// 若缺少此方法，[copyWith] 每次都会返回新实例，导致比较退化为引用比较，
  /// 从而无法精准判断某个 aspect 是否真的发生变化。
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          age == other.age &&
          isVip == other.isVip;

  @override
  int get hashCode => Object.hash(name, age, isVip);
}
