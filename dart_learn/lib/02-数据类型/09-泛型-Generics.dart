/*
<https://dart.cn/language/generics>
<https://dart.ac.cn/language/generics>

1、泛型
 定义：Dart 允许使用类型参数，限定类型的同时又让类型更加灵活，让代码更加健壮和维护性更强。
 例如：
    - List<E> 列表是一个泛型类型（或者 参数化类型），即一个具有形式类型参数的类型。
    - 大多数类型变量（或 类型占位符）都有单字母名称，如：E、T、S、K、V。
 
 常见应用场景：泛型集合、泛型方法、泛型类
 
2、使用泛型的优点：
 正确指定泛型类型可以生成更好的代码。
 可以使用泛型来减少重复代码。

 */

void main(List<String> args) {

  // 不使用泛型，可以存放任意类型
  List list = [];
  list.add('');
  list.add(true);
  list.add(12);
  print('--- 列表不使用泛型 = $list');

  /* 1、List、Set、Map 的字面量可以参数化。
  *   如下使用它们的类型字面量：
  */
  var arr1 = <String>['Seth', 'Kathy', 'Lars'];
  var set1 = <String>{'Seth', 'Kathy', 'Lars'};

  var map1 = <String, int>{
              'index.html': 1,
              'robots.txt': 2,
              'humans.txt': 3,
            };
  print('arr1 ${arr1.runtimeType}, set1 ${set1.runtimeType}, map1 ${map1.runtimeType}');    // 打印：arr1 List<String>, set1 _Set<String>, map1 _Map<String, int>

  // 将参数化类型与构造函数一起使用
  var setArr1 = Set<int>.from([1, 2, 3]);
  print('setArr = $setArr1, ${setArr1.runtimeType}');   // 打印：setArr = {1, 2, 3}, _Set<int>

  var dict = Map<int, String>();
  dict[1] = '队长';
  dict[2] = '队员';
  print('dict = $dict, ${dict.runtimeType}');   // 打印：dict = {1: 队长, 2: 队员}, _Map<int, String>

  print('---------------- 泛型函数');
  String str = getValue<String>("123");
  print('--- str = $str');

  printList<String>(arr1);

  Student<String> st = Student('张三');
  print(st.name);

}

// ---------- 2、定义泛型函数
T getValue<T>(T value) {
  return value;
}

void printList<T>(List<T> list) {
  for (var item in list) {
    print(item);
  }
}


// ---------- 3、定义泛型类
// 使用 extends 限制其参数必须是特定的类型。
class Student<T extends Object> {
  T? name;

  Student(this.name);
}


/* 2、使用泛型在许多类型之间共享单个接口和实现，减少代码重复。
 * 如下 T 是一个类型占位符，可以在使用时被定义成需要的类型。
 */
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}
