/* https://dart.cn/language/concurrency
 * 
 * 
 * 
 */


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


