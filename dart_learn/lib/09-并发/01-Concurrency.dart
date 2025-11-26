/* 
  <https://dart.cn/language/concurrency>
  <https://dart.ac.cn/language/concurrency>
 
 1、Dart 中的并发
 Dart 中的并发编程指的是 异步 API（如 Future 和 Stream）以及 isolates 隔离区（isolates 允许将进程移动到不同的CPU内核）。
 所有 Dart 代码都在 isolates 隔离区 中运行，从默认的 main isolate(主隔离区) 开始，并可选地扩展到您显式创建的任何后续的 isolates。
 
 
 2、Event Loop 事件循环
  Dart 的 runtime model(运行时模型) 基于 event loop(事件循环)。event loop 负责执行程序的代码、收集和处理事件等等。
  
  事件循环运行的过程：
    - 当 App 运行时，所有事件都会添加到一个称为 event queue(事件队列) 的队列中。
    - 事件可以是任何类型的操作，例如：重新绘制UI的请求，用户点击，磁盘的I/O操作等。
    - 因为你的 App 无法预测事件的发生顺序，所以 event loop(事件循环) 会按照事件排队的顺序处理事件，一次处理一个。
  
  事件循环的运行方式类似于以下代码：
     while (eventQueue.waitForEvent()) {
       eventQueue.processNextEvent();
     }
 
  如上事件循环是同步的，并且在单线程上运行。然而，大多数 Dart 应用程序需要同时执行多个操作。例如：App 需要执行 HTTP 请求，同时还要监听用户点击按钮的操作。
  为了解决这个问题，Dart 提供了许多异步 API（如 Future、Stream 和 async-await），这些 API 都是围绕这个事件循环构建的。

 3、事件循环处理异步操作的方式
  http.get('https://example.com').then((response) {
    if (response.statusCode == 200) {
      print('Success!');
    }  
  }

  - 当如上 http.get 到达事件循环时，它会立即调用第一个子句 http.get，并返回一个 Future。
  - 同时这段代码会告诉事件循环在 HTTP 请求解析之前，保留 then() 子句中的回调。
  - 当请求解析后，事件循环执行 then 子句的回调，并将请求结果作为参数传递。

 4、事件循环处理事件的顺序
  执行同步代码 -> 执行微任务队列 -> 执行事件队列 -> 依次反复...

  微任务队列：Future.microtask()
  事件队列：Future、Future.delayed()、I/O操作(文件、网络)等

 5、总结
  - Dart 是单线程语言，它通过事件循环处理事件，一次处理一个事件。
  - Dart 使用基于事件循环的异步API来处理耗时事件，使得 App 可以同时处理多个事件。



 3、异步编程 Future
  Future 表示异步操作的结果，该操作最终将以值 或 错误完成。
  async 和 await 关键字提供了一种声明式的方式 来定义异步函数并使用它们的结果。
  await 关键字仅适用于函数体之前具有 async 的函数。
 
 4、异步编程 Stream
  Dart 还支持 Stream(流) 形式的异步代码。Stream(流) 在未来提供值，并随着时间的推移重复提供值。
  随着时间的推移提供一系列int值的承诺具有Stream<int>类型。

 
 */
