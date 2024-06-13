/* https://dart.cn/language/concurrency
 * https://dart.cn/language/async
 * 
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