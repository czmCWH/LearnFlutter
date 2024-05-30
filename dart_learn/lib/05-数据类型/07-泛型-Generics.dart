/*
泛型：https://dart.cn/language/generics

大多数类型变量都有单字母名称，如：E、T、S、K、V。

泛型的好处：
* 正确指定泛型类型可以生成更好的代码。
* 可以使用泛型来减少重复代码。



 */

void testGenerics() {
  
  // 1、使用泛型定义为只能存储字符串的数组。
  var names = <String>[];
  names.addAll(['Seth', 'Kathy', 'Lars']);
  print('泛型数组: $names');

}

/* 2、使用泛型在许多类型之间共享单个接口和实现，减少代码重复。
 * 如下 T 是一个类型占位符，可以在使用时被定义成需要的类型。
 */
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}


void testCollectGenerics() {

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

  // 2、将参数化类型与构造函数一起使用
  var setArr1 = Set<int>.from([1, 2, 3]);
  print('setArr = $setArr1, ${setArr1.runtimeType}');   // 打印：setArr = {1, 2, 3}, _Set<int>
  
  var dict = Map<int, String>();
  dict[1] = '队长';
  dict[2] = '队员';
  print('dict = $dict, ${dict.runtimeType}');   // 打印：dict = {1: 队长, 2: 队员}, _Map<int, String>

}

/* 使用泛型：
 */
// 1、定义泛型类型时，限制其参数必须是特定的类型。
class Foo<T extends Object> {
  // Any type provided to Foo for T must be non-nullable.
}

// 2、定义函数或方法时，使用泛型参数
T first<T>(List<T> ts) {
  T tmp = ts[0];
  return tmp;
}