/*
    dart 操作符: https://dart.cn/language/operators
 */
void main(List<String> args) {
  print('------ 1、算术运算符');
  print(2 + 3);       // 加法：5
  print(2 - 3);       // 减法：-1
  print(5 / 2);       // 除法：2.5
  print(5 ~/ 2);      // 除法 取整：2
  print(5 % 2);       // 取余：1

  print('------- 2、前缀和后缀, 自增和自减运算符');
  var a = 10;
  var b = a++;
  print('b = $b');    // b = 10
  
  var a2 = 10;
  var b2 = ++a2;  
  print('b2 = $b2');    // b2 = 11


  print('------- 3、相等和比较运算符');
  // 比较运算符的结果都是布尔类型，如：==、!=、>、>=、<、<=
  print(' 2 == 2: ${ 2 == 2 }');    // true

  var i = 2;
  var j = 2;
  print(' i 和 j 是否是完全相同的对象: ${ identical(i, j) }');    // true

  print(' 2 >= 2 : ${ 2 >= 2 }');   // 2 >= 2 : true
  
  print(' 2 <= 2 : ${ 2 <= 2 }');   // 2 <= 2 : true

  testAssignmentOperators();

  testLogicalOperators();

  testConditionalExpr();
}


void testAssignmentOperators() {
  print('------- 4、赋值运算符：');
  
  /*  
   * = 运算符 用于分配值；
   * ??= 当被赋值的变量为null时，才会给它赋值。
   */

  var a = 100;
  int? b = 10;

  b ??= a;
  print(b);   // 10
    
  b = null;     // 只有当b为null时，才会进行赋值
  b ??= a;
  print(b);   // 100
  
  // Dart 还支持赋值运算符：+=、-=、*=、/= 
}

void testLogicalOperators() {
  print('------- 5、逻辑运算符：');
  
  /* 
    1、逻辑运算符
      !expr  取反表达式；
       ||  逻辑或
       &&  逻辑与
     
     使用逻辑运算符必须保证参与的变量为 布尔类型。
   */
   bool isOpenDoor = false;
   bool isOpenLight = true;
   print('isOpenDoor && isOpenLight = ${isOpenDoor && isOpenLight}');   // false
   print('isOpenDoor && isOpenLight = ${isOpenDoor || isOpenLight}');   // true
   print('!isOpenDoor = ${!isOpenDoor}'); // true
}

void testConditionalExpr() {
  print('------- 6、条件表达式：');

  /* Dart 有两个运算符，有时可以替换 if-else 表达式，让表达式更简洁：
   * 1、condition ? expr1 : expr2
   * 
   * 2、expr1 ?? expr2    如果 expr1 为非null，则返回其值；否则，计算并返回 expr2 的值。??又称为空合并运算符。
   *  
   */

  var score = 99;
  print(score >= 90 ? '优秀' : '及格');

  String? str = '123';
  str = null;
  print('str = ${ str ?? 'str 没有值'}');   // 打印：str = str 没有值

}
