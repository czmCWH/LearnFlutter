void main(List<String> args) {
    testTypeOperators();
}

void testTypeOperators() {

  /*
    1、类型运算符
     as， is， 和 is! 运算符用于在运行时处理类型检查。
     
     as：当且仅当确定对象属于特定类型时，使用 as 将对象强制转换为该类型。  
     is：如果您不确定该对象是否属于 T 类型，请在使用该对象之前使用 is T 检查类型。
     is!：如果对象是指定类型则返回 false。
   */  

  Object a = [1, 2, 3, 4];
  print(a is List);     // true
  print(a is! List);    // false
  print((a as List<int>).length);     // 4

}


void testCascadeOperations() {
  print('--- 级联运算符：');
  
  /* 
   * 级联（..，？..）允许对同一对象进行一系列操作。
   * 除了访问实例成员之外，还可以调用同一对象上的实例方法。这通常可以省去创建临时变量的步骤，并允许您编写更流畅的代码。
   * 
   * 严格来说，级联的`..`符号不是运算符。 它只是`Dart`语法的一部分。
   */



  /*
   * 如果级联操作的对象可以为 `null`，则对于第一个操作，请使用一个 null短路级联(?..)。 
   * 以 ?.. 开头的内容可保证不会对该空对象尝试任何级联操作。?.. 是 dart 2.12 版本引入的。 
   */

  /*
   * 注意：必须在返回实际对象的函数上构造级联。否则会报错。
   */

}

void testSpreadOperations() {
  print('--- 展开运算符：');

  /*
   * 展开运算符( ... or ...? )对 返回集合的表达式 计算，对结果值进行解包，然后将它们插入到另一个集合中。
   * 
   * 展开运算符实际上并不是一个运算符表达式。其语法是集合字面量本身的一部分。
   * 因为它不是运算符，所以没有任何运算符优先级，而是最低优先级。
   */
  var arr1 = [1, 2, 3];
  var arr2 = [4,5,6, ...arr1];
  print('arr = $arr2');   // 打印：arr = [4, 5, 6, 1, 2, 3]

  Set<int>? set1 = null;
  Set<int> set2 = {2, 3, 5, ...?set1};
  print('set = $set2');   // 打印：set = {2, 3, 5}


}
