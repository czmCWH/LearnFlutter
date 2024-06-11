/* https://dart.cn/language/libraries     
 * 使用 package：https://dart.cn/guides/packages
 * 
 * 1、import 和 library
 * 
 * import 和 library 指令用于创建模块化和可共享的代码库。
 *    Libraries(库) 不仅提供 API，而且是一个隐私单元:以下划线(_)开头的标识符仅在库内部可见。
 *    每个 Dart文件(加上它的各个部分)都是一个库，即使它不使用 library 指令。
 */ 
 
 
 
 /* 
 * 2、使用库
 * 
 * 使用 import 指定如何在另一个库的作用域中使用一个库中的名称空间。
 * 例如，Dart web应用程序通常使用 Dart:html 库，可以像如下导入:
 *    import 'dart:html';
 * 
 * 使用库时，唯一需要 import 的参数是指定库的URI。
 *    对于 Dart 内置库，URI 具有特殊的 dart:scheme。例如：import 'dart:math';
 *    对于其他库，可以使用 文件系统路径 或 package:scheme。package:scheme指定由包管理器(如: pub工具)提供的库。如下例子：
 *        import 'package:test/test.dart';
 * 
 */ 
 
 
 /* 
 * 3、as 指定库前缀，避免库冲突
 * 
 * 如果导入的两个库具有冲突的标识符，那么您可以为一个或两个库指定前缀。
 * 例如，如果 library1 和 library2 都有一个Element类，则可以如下：
 *  
 *  import 'package:lib1/lib1.dart';
 *  import 'package:lib2/lib2.dart' as lib2;
 *  
 *  // 使用 lib1  中的类型
 *  Element element1 = Element();
 *  
 *  // 使用 lib2 中和 lib1 同名的类型
 *  lib2.Element element2 = lib2.Element();
 */ 
 
 /* 
 * 4、仅导入库的一部分
 * 
 * 如果只想使用库的一部分，可以有选择地导入库。例如:
 * 
 * // 仅导入 foo
 * import 'package:lib1/lib1.dart' show foo;
 * 
 * // 导入除 foo 以外的所有
 * import 'package:lib2/lib2.dart' hide foo;
 * 
 */ 
 
 
 
 /* 
 * 5、web app 懒加载库
 * 
 * Deferred loading 延迟加载（也称为 lazy loading）允许【web app] 在需要库时按需加载库。
 * Dart 工具不支持 Web 以外目标的懒加载库。
 * 
 * 如果要满足以下一个或多个需求，请使用延迟加载库：
 *    1、减少 web app 的初始启动时间
 *    2、执行A/B测试。例如：尝试算法的替代实现。
 *    3、加载很少使用的功能，比如可选的屏幕和对话框。
 * 
 * 懒加载库使用 deferred as 将其导入，懒加载库语法：
 *    import 'package:greetings/hello.dart' deferred as hello;
 * 
 * 使用延迟加载时请记住以下几点：
 *    1、deferred library 的常量在 deferred library 被加载后，才会存在，可以被使用。
 *    2、不能在导入文件中使用来自 deferred library 的类型。
 */


 /* 
 * 6、library directive 库指令
 * 
 * 要指定库级 doc comments(文档注释) 或 metadata annotations(元数据注释)，请将它们附加到文件开头的库声明中。
 *
 */ 
 
 
 
 /* 
 * 7、实现 library
 * 
 */


