
import 'package:dart_learn/05-%E5%87%BD%E6%95%B0%E5%92%8C%E5%BC%82%E5%B8%B8/02-%E9%94%99%E8%AF%AF%E5%A4%84%E7%90%86.dart' as dart_error;



import 'package:dart_learn/08-%E7%B1%BB/07-%E7%B1%BB%E7%9A%84%E4%BF%AE%E9%A5%B0%E7%AC%A6/05-Mixins%E6%B7%B7%E5%85%A5%E7%B1%BB.dart' as dart_mixinss;

import 'package:dart_learn/10-并发/02-使用Future.dart' as dart_future;




// main 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。
void main(List<String> arguments) {
  

  print("---👇👇👇: 错误处理");
  dart_error.testCatch();
  dart_error.testRethrow();
  // dart_error.testFinally();


  print("---👇👇👇: 异步函数：");
  dart_future.getAsynFuncResult();
  dart_future.catchAsyncFuncError();
  dart_future.testFutureAPI();
}
