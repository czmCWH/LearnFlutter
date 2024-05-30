/*
 * Set: https://api.dart.cn/stable/3.4.0/dart-core/Set-class.html
 * 
 * Dart`中的 Set 是无序的、且元素不重复集合。Set 称为 集合。
 * 
 * 
 */
void testSet() {
  // 使用字面量方式创建 Set 集合
  var s1 = {'A', 'B', 'C'};
  Set s2 = {1, 2, 3};
  print(s1.runtimeType);
  print(s2.runtimeType);

  // 使用 Set 创建集合
  Set<String> s3 = {'aa', 'bb', 'cc'};
  print(s3.runtimeType);

  // 创建空Set 
  Set<String> s4 = {};
  Set s5 = <String>{};
  Set s6 = {};
  print('$s4 $s5 $s6');   // 打印：{} {} {}
  
  var s7 = {};   // 注意：这是创建一个 map，而不是 Set
  print(s7.runtimeType);  // 打印：_Map<dynamic, dynamic>
}

void testAddSet() {
  print('向 Set集合中添加元素: ');
  var st0 = {'11', '22', '33'};
  var st1 = <String>{};
  Set st2 = {};
    
  st1.add('aa');
  st1.addAll(st0);
  print(st1);   // 打印：{aa, 11, 22, 33}
    
  st2.add(1);
  st2.addAll(st0);
  print(st2);   // 打印：{1, 11, 22, 33}

  // 使用 length 获取item的个数
  print('${st2.length}');   // 打印：4
}

void testConstantSet() {
  print('创建编译时常量Set集合: ');
  // 创建一个编译时常量集合，需要在 Set字面量前面添加 const ：
  
  var s1 = const {1, 4, 5};
  //  s1.add(3);  // 会报错

  final s2 = const {1, 4, 5};
//   s2.add(3);  // 会报错
  
const Set s3 = {1, 2, 3};
//   s3.add(4);  // 会报错
}

/* `Set` 和 `List` 一样，都支持 `spread operators (... and ...?) ` 和 `collection if` 和 `for`. 
 */
void testCollectionSet() {
  print('Set 和 List 一样，都支持 spread operators 和 collections : ');
  Set s1 = const {1, 4, 5};
  Set<int> s2 = {3, 9, ...s1};
  print(s2);   // 打印 {3, 9, 1, 4, 5}
    
  Set<int>? s3;
  var s4 = {9, 2, 12, ...?s3};
  print(s4);   // 打印：{9, 2, 12}

  const res = false;
  var st1 = {1, 2, 3, if (res == false) 6};
  print(st1);   // 打印：{1, 2, 3, 6}
    
  var st2 = {"a", "b", for (var i in st1) "+$i"};
  print(st2);   // 打印：{a, b, +1, +2, +3, +6}
}