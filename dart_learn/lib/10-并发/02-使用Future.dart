/* 异步支持：https://dart.cn/language/async  
 * dart:async：https://dart.cn/libraries/dart-async#future
 * asynchronous programming codelab：https://dart.cn/codelabs/async-await
 * 
 * 1、异步支持
 * Dart 库中有很多返回 Future 或 Stream 对象的函数。这些函数是异步的：它们在设置一个可能耗时的操作（例如 I/O）后返回，而无需等待该操作完成。
 * 
 * 2、async 函数
 * 异步函数是指用 async 修饰符标记函数体的函数。通常异步函数返回一个 `Future` 对象。
 * 
 * 尽管异步函数可能执行耗时的操作，但它并不等待这些操作。
 * 而 async 函数只执行到遇到它的第一个 await 表达式 为止。然后它返回一个 Future 对象，只有在 await 表达式完成后才恢复执行。
 * 
 */

// 定义异步函数
Future<String> getVersion() async {
  return '1.0.0';
}

Future<String> returnFutureFunc() {
  // Future.delayed 工厂函数本身就返回一个 Future 对象
  return Future.delayed(
      const Duration(seconds: 2),
      () => 'Large Latte',
    );
}

 /* 
 * 1、Future
 * Future 类的实例，表示异步操作的结果。
 * 
 * Future 可以有两种状态：uncompleted(未完成) 或 completed(已完成)。
 * 
 * 1.1、uncompleted 未完成
 * uncompleted 是一个 Dart 术语，指的是未来在产生值之前的状态。
 * 
 * 当您调用异步函数时，它返回一个 uncompleted future。该 future 等待函数的异步操作 完成 或 抛出错误。
 * 
 * 1.2、Completed 已完成
 * 如果异步操作成功，则 future 以一个值结束。否则，它将以错误结束。
 * 
 * 用值完成
 * Future<T> 类型的 Future 以 T 类型的值完成。例如，
 *  Future<String> 类型的 Future 会产生一个字符串值。如果 Future 未产生可用值，则 Future 的类型为 Future<void>。
 * 
 * 1.3、用error完成
 *  如果函数执行的异步操作由于任何原因失败，则future以错误结束。
 * 
 */


Future<String> readContent(String str) async {
  return Future.delayed(const Duration(seconds: 2), () => '读取耗时内容: $str', );
}

Future<void> saveFile() async {
  Future.delayed(
    const Duration(seconds: 2), 
    () {
      print('异步函数 saveFile 没有返回结果。存储文件结束');
    },
  );
}

Future<String> asyncErrorFunc(int num) async {
  return Future.delayed(
    const Duration(seconds: 2),
    () {
      if (num%2 == 0) {
        throw Exception('参数不能为偶数');
      } else {
        return '参数为偶数: $num';
      }
    },
  );
}

 /* 
 * 2、使用 async 和 await 获取 Future 执行完成的结果
 * 
 * 在 await 表达式中，表达式的值通常为 Future；如果不是，则该值将自动包装在 Future 中。此 Future 对象表示返回对象的 promise。
 * Future 就像对未来某个时候提供的结果的 promise(承诺)。
 * 
 * async 和 await 关键字提供了一种声明性的方式来定义异步函数并使用其结果。使用 async 和 await 时请记住以下两个基本准则：
 *    要定义异步函数，请在函数体之前添加 async;
 *    await 关键字仅适用于异步函数;
 * 
 * async 和 await 关键字支持异步编程，让您可以编写与同步代码类似的异步代码。可以在 async 函数中多次使用 await。
 *  
 */
void getAsynFuncResult() async {

  // await 表达式会阻塞直到需要的对象返回。
  var res = await readContent('1');
  print('异步函数 readContent 执行完毕: $res');

  await saveFile();
  print('由于异步函数 saveFile 返回值为 void, 所以此处打印不会等待 saveFile执行完毕');  

}

 /* 
 * 3、使用 try-catch 处理异步函数的 error
 * 使用 try, catch 和 finally 来处理使用 await 的代码中的错误和清理.
 */

void catchAsyncFuncError() async {
  try {
    var res1 = await asyncErrorFunc(2);
    print('catch async, res1 = $res1');

    // res1 获取失败，此处 res2 的值不会执行。
    var res2 = await asyncErrorFunc(3);
    print('catch async, res2 = $res2');

  } catch (e) {
    print('--- 捕获错误: $e');
  }
}




/* 
 * 1、使用 Future API
 * https://dart.cn/libraries/dart-async#future
 * 
 * 在直接使用 Future API 之前，请考虑使用 await 代替。使用 await 表达式的代码比使用 Future API 的代码更容易理解。
 * 
 * import 'dart:async';
 * 
 */

void testFutureAPI() async {

  // 使用 Future API 获取异步函数的结果

  var res = await readContent('1').then((value) {
    return readContent('$value, 2');
  }).then((value) {
    return readContent('$value, 3');
  }).then((value) => value);

  print('--- Future API, res = $res \n');

  asyncErrorFunc(2).then((value) {
    
    print('value = $value');

  }, onError: (e) {

    print('onError, e = $e');

    // 注意：如果不返回 e，则不会执行 catchError
    return e;    

  }).catchError((e) {
    print('--- catch e = $e');
  });

}









/*
 * 
 * 对于UI事件监听器，通常不应该使用 await For，因为UI框架会发送无尽的事件流。
 * 
 */
