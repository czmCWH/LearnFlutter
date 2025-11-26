/*
 <https://api.dart.cn/stable/3.4.1/dart-core/Enum-class.html>
 <https://dart.ac.cn/language/enums>
 <https://dart.cn/language/enums>
 
 enum 枚举是一种特殊的类，用于表示固定数量的常量值。
 枚举类型具有以下限制： 枚举不能被子类化，`mixin`或`implements`。枚举不能被显式实例化。
  
 */
import 'dart:core';

void main(List<String> args) {
   print(Weeks.tuesday.index);     // 打印：1
}


 /* 1、声明简单的枚举类型
   * 在声明枚举类型时使用尾随逗号，以帮助防止复制粘贴错误。
   */
enum Weeks { monday, tuesday, wednesday, }
