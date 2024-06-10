/* https://dart.cn/language/libraries     https://dart.cn/guides/packages
 * 
 * 1、import 和 library
 * import 和 library 指令用于创建模块化和可共享的代码库。
 *    Libraries(库) 不仅提供 API，而且是一个隐私单元:以下划线(_)开头的标识符仅在库内部可见。
 *    每个 Dart文件(加上它的各个部分)都是一个库，即使它不使用 library 指令。
 * 
 * 
 * 2、使用库
 * 使用 import 指定如何在另一个库的作用域中使用一个库中的名称空间。
 * 例如，Dart web应用程序通常使用 Dart:html 库，可以像如下导入:
 *    import 'dart:html';
 * 
 * 使用库时，唯一需要 import 的参数是指定库的URI。
 *    对于内置库，URI 具有特殊的 dart:scheme。
 *    对于其他库，可以使用 文件系统路径 或 package:scheme。package:scheme指定由包管理器(如: pub工具)提供的库。如下例子：
 * import 'package:test/test.dart';
 * 
 * 
 * 3、指定库前缀，避免库冲突
 * 如果导入的两个库具有冲突的标识符，那么您可以为一个或两个库指定前缀。
 * 例如，如果 library1 和 library2 都有一个Element类，则可以如下：
 *  
 *  import 'package:lib1/lib1.dart';
 *  import 'package:lib2/lib2.dart' as lib2;
 *  
 *  // Uses Element from lib1.
 *  Element element1 = Element();
 *  
 *  // Uses Element from lib2.
 *  lib2.Element element2 = lib2.Element();
 * 
 * 
 * 4、仅导入库的一部分
 * 如果只想使用库的一部分，可以有选择地导入库。例如:
 * // 仅导入 foo
 * import 'package:lib1/lib1.dart' show foo;
 * 
 * // 导入除 foo 以外的所有
 * import 'package:lib2/lib2.dart' hide foo;
 * 
 * 
 * 5、懒加载库
 * 延迟加载（也称为延迟加载）允许web应用程序在需要库时按需加载库。如果要满足以下一个或多个需求，请使用延迟加载。
 * 
 * 
 * 
 */


