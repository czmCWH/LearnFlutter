/* 
 dart:async：https://dart.cn/libraries/dart-async
 asynchronous programming codelab：https://dart.cn/codelabs/async-await
 Future<T> class：https://api.dart.cn/dart-async/Future-class.html



异步操作可能需要等待程序外部的某些操作（读取文件、查询数据库、获取网页），这可能需要时间。
异步操作不会在其结果可用之前阻塞所有操作，而是立即返回一个 Future 对象，当 Future 对象处于 completed 时，异步操作结束。

 1、Future
  Future 表示异步操作的结果。Future 对象会在未来某个时间点返回计算完成时的值。
  Future 有两种状态：uncompleted(未完成) 或 completed(已完成)。

  - uncompleted，指的是未来在产生值之前的状态。
  当您调用异步函数时，它会立即返回一个 uncompleted future。该 future 等待函数的异步操作 完成 或 抛出错误。
  
  - Completed，表示异步操作结束，如果操作成功 Future 返回一个值；如果操作失败，则返回一个错误。
 
  Future<T> 表示 Future 以 T 类型的值完成，即当 Future 完成时会返回一个 T 类型的值。
  Future<void> 表示 Future 完成时不会返回值。
  如果函数执行的异步操作由于任何原因失败，则 future 以错误结束。


 2、处理 Future 的返回值
  Dart 提供2种方式来处理 Future 的结果：
    方式1，await Future 对象；
      - 当在函数内使用 await 时，需要在函数体之前标记为 async；
      - await 等待 Future 对象完成时的值，会阻塞所在的 async 函数，但程序不会被阻塞；
      - try-catch-finally 捕获 Future 抛出的错误；
      - async 和 await 关键字支持异步编程，让您可以编写与同步代码类似的异步代码;

    方式2，Future API
      - 通过 then、catchError、whenComplete 来向 Future 对象注册回调函数；
      - 注册回调的结果本身也是一个 Future；
    
  方式1 是基于 方式2 实现的，then().catchError() 模式是 try-catch 的异步版本。
 */

void main(List<String> args) async {
  
  // 1、创建有返回值的 Future 并处理它
  Future<String> fut1 = Future(() {
    return "我是的 fut1 的值";
  });

  // 使用 then() 来注册 Future 完成时的回调
  fut1.then((value) {
    print("fut1 value = $value");
  }).whenComplete(() {
    print("fut1 处理结束了");
  });
  
  String fut1Value = await fut1;
  print("fut1Value = $fut1Value");

  // 2、创建没有返回值的 Future
  Future<void> fut2 = Future(() {
    print('我是没有返回值的 fut2');

  });

  fut2.then((_) {
    print("fut2 处理完毕了");
  });

  // 3、创建返回错误的 Future
  Future fut3 = Future(() {
    throw Exception("fut3 执行错误！");
  });

  // 使用 catchError 来处理 Future 对象抛出的错误
  fut3.catchError((error){
    print("fut3 出错了 $error");
  });

  // try-catch-finally 捕获 Future 对象抛出的异常
  try {
    final res = await fut3;
    print('--- fut3 返回一个值，res = $res');
  } catch (e) {
    print("--- e = $e");
  } finally {
    print("--- fut3 执行结束，进行必要清理！");
  }

  // 4、创建一个在延迟后执行其计算的异步操作
  var fut4 = Future.delayed(const Duration(seconds: 2), () {
    print("fut4 延迟了2秒执行");
  } );
  fut4.whenComplete(() {
    print("fut4 执行结束了");
  });
  

}

