/* https://dart.cn/language/extension-methods
 * 
 * 1、扩展方法
 * 扩展方法用于为现有库添加功能。
 * 扩展不仅可以定义方法，还可以定义其他成员，如 getter、 setter 和操作符。语法如下：
 * 
 *  extension <extension name>? on <type> { // 扩展名可以不写
 *    (<member definition>)* // 定义扩展的成员(方法、 getter、 setter 或运算符)
 *  }
 * 
 * 使用 extension 方法只需导入它所在的库。
 * 
 * 2、不能对动态类型的变量调用扩展方法。
 * 
 * 3、如果扩展成员与接口或其他扩展成员冲突，那么有下面2个选项：
 *  改变导入冲突扩展的方式；
 *  使用show或hide来限制暴露的API
 * 
 * 4、
 * 
 */


extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }
}

void testExtensin() {
  // 
  dynamic d = '2';
  print(d.parseInt()); 
}