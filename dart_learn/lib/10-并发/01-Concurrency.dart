/* https://dart.cn/language/concurrency
 * 
 * 1、Dart 中的并发
 * Dart 中的并发编程既指异步 API（如 Future 和 Stream），也指 isolates(隔离)。
 * isolates(隔离)允许您将进程移动到单独的内核。
 * 
 * 所有 Dart 代码都在 isolates(隔离区) 中运行，从默认的 main isolate(主隔离区) 开始，并可选地扩展到您显式创建的任何后续的 isolates。
 * 
 * 
 * 2、Event Loop 事件循环
 * Dart 的 runtime model(运行时模型) 基于 event loop(事件循环)。
 * event loop 负责执行程序的代码、收集和处理事件等等。
 * 
 * 当 App 运行时，所有事件都会添加到一个称为 event queue(事件队列) 的队列中。
 * 事件可以是任何内容，从重新绘制UI的请求，到用户敲击和击键，再到来自磁盘的I/O。
 * 因为你的 App 无法预测事件的发生顺序，所以 event loop(事件循环) 会按照事件排队的顺序处理事件，一次处理一个。
 * 
 * 事件循环的运行方式类似于以下代码：
 *    while (eventQueue.waitForEvent()) {
 *      eventQueue.processNextEvent();
 *    }
 * 
 */


/* 
 * 1、异步编程 Future
 * 
 * Future 表示异步操作的结果，该操作最终将以一个值或一个错误完成。
 * async 和 await 关键字提供了一种声明式的方式 来定义异步函数并使用它们的结果。
 * wait 关键字仅适用于函数体之前具有 async 的函数。
 *
 */


 /* 
 * 2、异步编程 Stream
 * Dart 还支持 Stream(流) 形式的异步代码。Stream(流) 在未来提供值，并随着时间的推移重复提供值。
 * 随着时间的推移提供一系列int值的承诺具有Stream<int>类型。
 *
 * 
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
 * 4、isolates
 * 
 * 除了异步 API 之外，Dart 还通过 isolates(隔离) 支持并发。
 * 
 * 为了利用多核，开发人员有时会使用并发运行的共享内存线程。然而，共享状态并发很容易出错，并可能导致复杂的代码。
 * 
 * 所有 Dart 代码都在 isolates(隔离) 内运行，而不是线程。
 * 使用 isolates(隔离)，您的 Dart 代码可以一次执行多个独立的任务。
 * isolates(隔离) 类似于线程或进程，但每个 isolates(隔离) 都有自己的 内存 和 运行 event loop 的单个线程。
 * 
 * 每个 isolates 都有自己的 global fields(全局字段)，确保 isolates 中的任何状态都不能从任何其他 isolates 访问。
 * isolates 只能通过消息传递相互通信。
 * isolates 之间没有共享状态，这意味着在 Dart 中不会出现像 互斥锁 或 锁 这样的并发 复杂性 和 数据竞争。也就是说，isolates 并不能完全防止竞争条件。
 * 有关此并发模型的更多信息，请阅读 Actor 模型。
 * 
 * 只有Dart Native平台实现了隔离。Dart Web平台没有。
 * 
 * 
 */


/*
 * 5、main isolate
 * 大多数情况下，你根本不需要考虑 isolate(隔离)。Dart 程序默认在 main isolate 中运行。它是程序开始运行和执行的线程，如下图所示：
 * 
 * 即使是 单隔离程序 也可以顺利执行。在继续执行下一行代码之前，这些应用程序使用 async-await 等待异步操作完成。
 * 运行良好的应用程序启动速度很快，尽快进入事件循环。然后，应用程序会根据需要使用异步操作及时响应每个排队事件。
 *  
 */