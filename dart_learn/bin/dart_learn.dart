import 'package:dart_learn/10-并发/02-使用Future.dart' as dart_future;


// main 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。
void main(List<String> arguments) {


  print("---👇👇👇: 异步函数：");
  dart_future.getAsynFuncResult();
  dart_future.catchAsyncFuncError();
  dart_future.testFutureAPI();
}
