/*
 * 有关配置集合包含的类型的详细信息，请查看 Generics泛型 <https://dart.cn/language/generics>。
 * List：https://api.dart.cn/stable/3.4.0/dart-core/List-class.html
 */


void main() {
  // testNumbers();
  testList();
}

void testList() {
  /**
   * 在Dart中，数组是 List对象，称它为列表。
   * 
   * 使用 .length 属性获取列表的长度，列表使用从零开始的索引。
   * 通常在 literal List 的最后一项添加逗号，防止复制粘贴错误。
   */

  // 定义列表变量
  List ls1 = [1, 2, 3, '你好'];
  // 使用类型注释定义列表变量
  List<String> ls2 = [];
  // 创建一个编译时常量(compile-time constant)列表
  var ls3 = const [1, 2, 3, ];
  print('$ls1, ${ls1.runtimeType}, $ls2, $ls3');    // [1, 2, 3, 你好], List<Object>, [], [1, 2, 3]
  print('${ls1.length}, ${ls2.length}, ${ls3.length}');   // 3, 0, 3

  const List ls4 = [1, 2, 3];
   // 如下都报错：Unsupported operation: Cannot modify an unmodifiable list
  // ls3[0] = 10;  
  // ls4[0] = 10;

  ls1.addAll(ls3);
  print(ls1);

  List ls5 = List.generate(3, (index) => index*3);    // List 生成器创建 List: [0, 3, 6]
  print('List 生成器创建 List: $ls5');

}

/*  Dart 2.3 对 List 引入的操作符，用于 List 合并
 *
 * spread operator(扩展操作符)：... 。
 * null-aware spread operator(空感知扩展操作符)：...?。如果右边的表达式可能为 null，则可以通过使用可识别 null 的扩展运算符（...？）来避免出现异常。
 * 
 */
void testListSpread() {
  print('List 的扩展操作符:');
  List ls1 = const [1, 2, 3];
  var ls2 = [4, 5, 6, ...ls1];
  print(ls2);   // 打印：[4, 5, 6, 1, 2, 3]

  List<int>? ls3;
  print(ls3);   // 打印：null
  
  List ls4 = [1, 2, 3, ...?ls3];
  print(ls4);   // 打印：[1, 2, 3]
}

void testCreateList() {
  print('使用 Dart 条件运算符(if、for)创建 List。');

  var res = true;
  List<int> ls1 = [1, 2, 3, if (res) 123];
  print(ls1);     // 打印：[1, 2, 3, 123]

  var ls2 = [1, 2, 3];
  var ls3 = ['a', for (var i in ls2) "+$i"];
  print(ls3);   // 打印：[a, +1, +2, +3]    
}

/**
 * List 的内置方法：
 * forEach、remove、insert、sublist、indexOf...
 * 
 */

void testElement() {
  List ls = [];
  ls.add(0);
  ls.add('');
  ls.add(null);

  if (ls[0] == null || ls[0] == '' || ls[0] == 0) {
    print('1--- ls[0] is empty');
  }

  // 简化判断元素是否为空
  if ([null, '', 0].contains(ls[0])) {
    print('2--- ls[0] is empty');
  }

}