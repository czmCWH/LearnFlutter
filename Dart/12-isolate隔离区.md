# isolate 隔离区

为了有效利用多核性能，开发者一般使用共享内存的方式让线程并发地运行。然而，多线程共享数据通常会导致很多潜在的问题，并导致代码运行出错。

为了解决多线程带来的并发问题，`Dart` 使用 `isolate` 替代线程，所有的 `Dart` 代码均运行在一个 `isolate` 中。每一个 `isolate` 有它自己的堆内存以确保其状态不被其它 `isolate` 访问。

所有的 `Dart` 代码都是在一个 `isolate` 中运行，而非线程。每个 `isolate` 都有一个单独的执行线程，并且不与其他的 `isolate` 共享任何可变对象。




https://dart.cn/guides/language/concurrency
