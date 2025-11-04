/*
 * 有关配置集合包含的类型的详细信息，请查看 Generics泛型 <https://dart.cn/language/generics>。
 * List：https://api.dart.cn/stable/3.4.0/dart-core/List-class.html
 */

void main() {
  /*
    1、List 列表
     在 Dart 中，数组是 List对象，称它为列表。
    
     List 使用从零开始的索引。length 属性获取列表的长度。
     通常在 literal List 的最后一项添加逗号，防止复制粘贴错误。
   */

  // 定义列表变量
  List ls1 = [1, 2, 3, '你好'];
  print("ls1 = $ls1, length = ${ls1.length}, ${ls1.runtimeType}");  // ls1 = [1, 2, 3, 你好], length = 4, List<dynamic>
  
  // 使用类型注释定义列表变量
  List<String> ls2 = [];
  print("ls2 = $ls2, length = ${ls2.length}");  // ls2 = [], length = 0
  
  // 创建一个编译时常量(compile-time constant)列表
  const List ls3 = [1, 2, 3];
  var ls4 = const [1, 2, 3, ];
   // 如下都报错：Unsupported operation: Cannot modify an unmodifiable list
  // ls3[0] = 10;  
  // ls4[0] = 10;

  print('ls3 first = ${ls3.first}');  // 1
  print('ls3 last = ${ls3.last}');    // 3

  print("-----------------------------");

  ls1.addAll(ls3);
  print("--- ls1 = $ls1");  // [1, 2, 3, 你好, 1, 2, 3]

  // List 生成器创建 List: [0, 3, 6]
  List ls5 = List.generate(3, (index) => index*3);    
  print('List 生成器创建 List: $ls5');  // [0, 3, 6]

  print("-----------------------------");

  /*
    Dart 2.3 对 List 引入 扩展操作符，用于 List 合并
     spread operator(扩展操作符)：... ；
     null-aware spread operator(空感知扩展操作符)：...?。如果右边的表达式可能为 null，则可以通过使用可识别 null 的扩展运算符（...？）来避免出现异常；
   */
  List arr = const [1, 2, 3];
  var arr1 = [4, 5, 6, ...arr];
  print("arr1 = $arr1");   // 打印：[4, 5, 6, 1, 2, 3]

  List<int>? arr2;
  print("arr2 = $arr2");   // 打印：null
  
  List arr3 = [1, 2, 3, ...?arr2];
  print("arr3 = $arr3");   // 打印：[1, 2, 3]

  print("-----------------------------");

  /**
    使用 Dart 条件运算符(if、for)创建 List
   */
  var res = true;
  List<int> result = [1, 2, 3, if (res) 123];
  print("result = $result");     // 打印：[1, 2, 3, 123]

  var result1 = [1, 2, 3];
  var result2 = ['a', for (var i in result1) "+$i"];
  print("result2 = $result2");   // 打印：[a, +1, +2, +3]
  
  print("-----------------------------");

  /**
    List 的内置方法：
      forEach、remove、insert、sublist、indexOf...

   */
  List ls = [];
  // isEmpty，数组是否为空，即没有任何元素
  print("ls.isEmpty = ${ls.isEmpty}");  // true
  ls.add(null);
  print("ls.isEmpty = ${ls.isEmpty}");  // false
  ls.add(0);
  ls.add('');

  if (ls[0] == null || ls[0] == '' || ls[0] == 0) {
    print('1--- ls[0] is empty');
  }

  print("ls.isEmpty = ${ls.isEmpty}");

  // 简化判断列表元素是否为空
  if ([null, '', 0].contains(ls[0])) {
    print('2--- ls[0] is empty');
  }

  print("-----------------------------");
  listFunc();
}

void listFunc() {
  List students = ['张三', '李四', '王五'];

  print("--- forEach、for 遍历 List: ");
  students.forEach((item) {
    print("item = $item");
  });

  for (var item in students) {
    print("item = $item");
  }

  print("--- every 函数，所有元素是否都满足某个条件: ");
  var res = students.every((item) {
    return item.toString().startsWith("张");
  });
  print("every res = $res");  // every res = false

  print("--- where 函数，筛选出满足条件的元素：");
  var newList = students.where((item) {
    return item.toString().startsWith("王");
  }).toList();
  print("where newList = $newList");  // newList = [王五]

}
