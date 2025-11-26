/*
 <https://dart.cn/libraries/async/async-await>
 
 1、异步函数
  Dart 异步函数是指 函数体使用 async 修饰符标记，返回值为 Future<T>。或 函数体使用 async* 修饰符标记，返回值为 Stream<T 。
  Dart 执行异步函数时，只是设置一个可能耗时的操作（例如 I/O）后立即返回，而无需等待该操作完成。 

 2、async 和 await 的执行流程
  async 函数会同步运行，直到遇到第一个 await 关键字。这意味着在 async 函数体内，第一个 await 关键字之前的所有同步代码都会立即执行。
 
*/

void main(List<String> args) async {

  // 1、调用异步函数，并获取其完成时的返回值
  getVersion().then((value) {
    print("--- 1、value = $value");
  }).whenComplete(() {
    print("--- 1 结束");
  });

  print("\n--- 开始调用 doNothing");
  await doNothing();
  print("--- 调用 doNothing 结束\n");


  delayFunc('11').then((value) {
    print("--- 延迟执行 = $value");
  });

  errorFunc(2).then((str) {
    print("---捕获错误1 str = $str");
  }).catchError((error) {
    print("---捕获错误1 error = $error");
  });

  try {
    var str = await errorFunc(2);
    print("---捕获错误2 str = $str");
  } catch (error) {
    print("---捕获错误2 error = $error");
  }

  print("\n");
  print("--- then() 链式调用异步函数的方式得到异步结果");
  
  var res = await delayFunc('1').then((value) {
    // 异步函数 readContent('1') 执行完成时，会调用此处代码
    return delayFunc('$value, 2');
  }).then((value) {
    return delayFunc('$value, 3');
  }).then((value) => value);
  print('--- Future API, res = $res \n');   // res = 耗时: 耗时: 耗时: 1, 2, 3 

  print("\n");
  print("--- 同时 await 多个 Future");
  /*
    方式1、Future.wait() 
      Future.wait静态方法管理多个 Future 并等待它们完成：
      多个 Future 都完成时，如果全部成功，则返回结果；如果任何 Future 失败则返回 error
   */
   var mutRes = await Future.wait([
    errorFunc(1),
    errorFunc(3),
    errorFunc(5),
  ]);
  print('--- mutRes = $mutRes');  // 打印：--- mutRes = [参数为奇数: 1, 参数为奇数: 3, 参数为奇数: 5]

  print("---- 处理多个 future 的错误");
  // 方式1: 等待所有 Future 完成，如果所有 Future 完成结果都成功，则执行 try；否则执行 catch。
  try {
    var results = await [errorFunc(2), errorFunc(3), errorFunc(4)].wait;
    print('---- try mut error res = $results');

  } on ParallelWaitError catch (e) {
    print('--- 打印成功 Future 的值，如果为值为 null, 则表示结果为 error');
    print(e.values[0]);    
    print(e.values[1]);    
    print(e.values[2]);   

    print('--- 打印 Future error 的值，如果值为 null, 则 Future 结果成功。');
    print(e.errors[0]);    
    print(e.errors[1]);   
    print(e.errors[2]);  
  }

  // 方式2: 
  try {    

    (String, String, String) result = await (errorFunc(2), errorFunc(3), errorFunc(4)).wait;
    print('---- 方式2, result = $result');
    
  } on ParallelWaitError catch (e) {
      print('方式2, error : $e');
    }

}

// 1、定义一个简单异步函数
Future<String> getVersion() async {
  // Dart 会在必要时创建 Future 对象。
  return '1.0.0';
}

// 2、如果异步函数没有显式返回值，请将其返回类型设置为 Future<void>
Future<void> doNothing() async {
  print('-----做了许多事情');
}

// 3、Future.delayed 工厂函数本身就返回一个 Future 对象
Future<String> delayFunc(String str) {
  return Future.delayed(
      Duration(seconds: 1),
      () => '耗时: $str',
    );
}

// 4、定义抛出错误的异步函数
Future<String> errorFunc(int num) async {
  return Future.delayed(
    const Duration(seconds: 2),
    () {
      if (num%2 == 0) {
        throw Exception('参数不能为偶数');
      } else {
        return '参数为奇数: $num';
      }
    },
  );
}
