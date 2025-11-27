/* 
 https://dart.cn/language/concurrency
 https://dart.cn/language/async
   
   
    
 */

void testStream() {
  // 使用 Stream.periodic 创建的 Stream 每秒重复发出一个新的 int 值
  Stream<int> stream = Stream.periodic(const Duration(seconds: 1), (i) => i * i);

}


 /*  
 * 3、await-for 和 yield
 * wait-for 是 for循环的一种类型，它在提供新值时执行循环的每次后续迭代。换句话说，它用于“循环遍历”流。
 * 
 */
Stream<int> sumStream(Stream<int> stream) async* {
  var sum = 0;
  await for (final value in stream) {
    // 在返回值流的函数中使用 yield 关键字而不是 return
    yield sum += value;
  }
}

void testAwaitFor() {
  // Stream<int> stream = sumStream(8);
}


/*
 * 3、处理流 Stream
 * 当您需要从 Stream 获取值时，您有两种选择：
 *    1、使用 async 和异步 for 循环（await for）
 *    2、使用 Stream API，如 dart:async 文档中所述。
 * 
 * 表达式的值必须是 Stream 类型。执行程序如下:
 * 1、等待，直到流发出一个值。
 * 2、执行for循环的主体，将变量设置为发出的值。
 * 3、重复1和2，直到流关闭。
 * 
 * 要停止侦听 stream，可以使用 break 或 return 语句，这将跳出 for 循环并从 stream 中取消订阅。
 * 
 * 
 */








/*


# Stream

在 `Dart API` 中 [Stream](https://api.dart.cn/stable/2.16.2/dart-async/Stream-class.html) 对象随处可见，`Stream` 用来表示一系列数据。例如，`HTML` 中的按钮点击就是通过 `stream` 传递的。同样也可以将文件作为数据流来读取。



## 处理 Stream

如果想从 `Stream` 中获取值，可以有两种选择：

* 使用 `async` 关键字和一个 异步循环（使用 `await for` 关键字标识）。

* 使用 [Stream API](https://dart.cn/guides/libraries/library-tour#stream)。

> 在使用 `await for` 关键字前，确保其可以令代码逻辑更加清晰并且是真的需要等待所有的结果执行完毕。例如，通常不应该在 `UI` 事件监听器上使用 `await for` 关键字，因为 `UI` 框架发出的事件流是无穷尽的。


### 使用 `async` 和 `await for`

* 必须确保 `await for` 处于异步函数中，否则会编译时错误。

使用 await for 定义异步循环看起来是这样的：

```Dart
await for (varOrType identifier in expression) {
  // 每次 stream 发出值时执行
}
```

表达式 的类型必须是 Stream。执行流程如下：

1、等待直到 Stream 返回一个数据。

2、使用 1 中 Stream 返回的数据执行循环体。

3、重复 1、2 过程直到 Stream 数据返回完毕。

使用 break 和 return 语句可以停止接收 Stream 数据，这样就跳出了循环并取消注册监听 Stream。

```Dart
void main() async {
  // ...
  await for (final request in requestServer) {
    handleRequest(request);
  }
  // ...
}
```
 */