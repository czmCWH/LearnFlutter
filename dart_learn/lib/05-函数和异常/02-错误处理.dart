/* https://dart.cn/language/error-handling
 * 
 * Dart 可以 throw(抛出) 和 catch(捕获) exception(异常)。
 * 
 * 异常是指发生了意外的错误。如果没有捕获到异常，则引发异常的 isolate(隔离区) 将被挂起，并且通常会终止 isolate对象 及其程序。
 * Dart 的所有异常都是未经检查的异常。方法不声明它们可能抛出的异常，也不要求捕获任何异常。
 * 
 * Dart 提供了 Exception 和 Error 类型，以及许多预定义的子类型作为异常类型。
 * 但是，Dart 程序可以抛出任何非空对象作为异常。
 * 
 * 生产质量的代码通常会抛出实现 Error 或 Exception 的类型。
 * 
 */

// 1、定义函数抛出异常
void testThrow(int a) {
  switch (a) {
    case -1:
      throw FormatException('Exception 类型的异常, a 不能为 -1');   
    case 0:
      throw 'a 不能为 0';    // 可以抛出任意对象
    case 100:
      throw UnimplementedError('error 类型的异常, a 的值不能为100。'); 
    default:
      print('num is $a');
      break;
  }
}

// 2、捕获异常
void testCatch() {
  try {
  
    testThrow(0);
  
  } on FormatException catch (e) {

    print('FormatException 类型的异常： $e');

  } on UnimplementedError catch (e, s) {    // s 表示堆栈跟踪（StackTrace 对象）

    print('UnimplementedError 类型的异常： $e');
    print(s);

  } catch (e) {
    
    print('其它类型的异常： $e');

  }
}

// 3、处理部分异常，同时允许异常继续传播使用 rethrow 关键字。
void testRethrow() {
  try {
  
    testThrow(-1);
  
  } on FormatException {

    print('FormatException 类型的异常');

  } catch (e) {
    rethrow;
  }
}

/*
 * 4、为确保某些代码无论是否引发异常都可以运行，请使用 finally 子句。 
 * 如果没有 catch子句 与 异常匹配，则在 finally子句 运行后传播异常。
 */
void testFinally() {
  try {
    testThrow(-1);
  } finally {
    print('就算发生了异常, finally 子句中的代码也必须执行完毕。然后再抛出可能发生的异常。');
  }
}
