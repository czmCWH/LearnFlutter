/* https://dart.cn/language/concurrency
 * 
 * 1、Dart 中的并发
 * Dart 中的并发编程既指 异步API(如 Future 和 Stream)，也指 isolates(隔离)。
 * isolates(隔离) 允许你将 进程 移动到单独的内核。
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
 * Future 表示异步操作的结果，该操作最终将以一个值 或 一个错误完成。
 * async 和 await 关键字提供了一种声明式的方式 来定义异步函数并使用它们的结果。
 * await 关键字仅适用于函数体之前具有 async 的函数。
 * 
 * 2、异步编程 Stream
 * Dart 还支持 Stream(流) 形式的异步代码。Stream(流) 在未来提供值，并随着时间的推移重复提供值。
 * 随着时间的推移提供一系列int值的承诺具有Stream<int>类型。
 *
 * 
 */
