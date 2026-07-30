/// 控制局部刷新的枚举（对应 User 的不同属性）。
///
/// 每个枚举值代表一个“切面（aspect）”。子 Widget 订阅自己关心的 aspect，
/// 当对应字段变化时才会重建，其他字段变化不会触发该 Widget 重建。
enum UserAspect {
  /// 姓名切面。
  name,

  /// 年龄切面。
  age,

  /// VIP 状态切面。
  vip,
}
