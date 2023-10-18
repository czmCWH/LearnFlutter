## 异步支持

`Dart`库中有大量返回 `Future` 或 `Stream` 对象 的函数，这些函数是异步的，它们会在耗时操作（比如I/O）执行完毕前直接返回而不会等待耗时操作执行完毕。


## 声明异步函数

异步函数 是函数体由 `async` 关键字标记的函数，通常异步函数返回一个 `Future` 对象。

如果异步函数没有返回有效值， 需要设置其返回类型为 `Future<void>`。

```Dart
Future<String> lookUpVersion() async {
  return '1.0.0';
}

Future<String> textPrint(String str) async {
  
  return Future.delayed(
    const Duration(seconds: 2),
    () {
      return str;
    },
  );
}
```

## 处理 Future

可以通过下面两种方式，获得 `Future` 执行完成的结果：

* 使用 `async` 和 `await`。
* 使用 [Future API](https://dart.cn/guides/libraries/library-tour#future)。

### 使用 `async` 和 `await`

异步函数在处理耗时操作时，它不会等待这些耗时操作完成，当其遇到第一个 `await` 表达式（代码行）时返回一个 `Future` 对象，然后等待 `await` 表达式执行完毕后继续执行。

* 必须在带有 `async` 关键字的 异步函数 中使用 `await`。可以在异步函数中多次使用 `await` 关键字。

* 使用 `async` 和 `await` 的代码是异步的，但是看起来有点像同步代码。 `await` 等待异步函数的执行结果。

* 在直接使用 `Future API` 前，首先应该考虑 `await` 来替代。代码中使用 `await` 表达式会比直接使用 `Future API` 更容易理解。

```Dart
Future<String> textPrint(String text) async {
  return text;
}

void main() async {
  
  var text = await textPrint("李四");
  print("text = ${text}");    // 打印：text = 李四
  
  // 拿到返回的 text 后才继续执行.....
  
  var text1 = textPrint("张三");
  print("text1 = ${text1}");    // 打印：text1 = Instance of '_Future<String>'
  
}
```

* 使用 `try`， `catch`， 和 `finally` 来处理代码中使用 `await` 导致的异常错误。

```Dart
void main() async {
  try {
    var text = await textPrint("张三");
  } catch (e) {
    print(e);
  }
}
```

`await` 表达式的返回值通常是一个 `Future` 对象；如果不是的话也会自动将其包裹在一个 `Future` 对象里。 `Future` 对象代表一个“承诺”， `await` 表达式会阻塞直到需要的对象返回。

### 使用 Future API

[Future<T> class Null safety](https://api.dart.cn/stable/2.16.2/dart-async/Future-class.html)，用于异步计算结果。可查看 [Future 库概览](https://dart.cn/guides/libraries/library-tour#future)。

`Future`， `Stream`，以及更多内容，参考 [dart:async library](https://api.dart.cn/stable/2.16.2/dart-async/dart-async-library.html)。

同步计算通过`return`或`throw`值立即计算结果，而异步计算在启动时不能立即提供结果。异步计算可能需要等待程序外部的东西（读取文件、查询数据库、获取网页），这些都需要时间。异步计算不是阻塞所有的计算直到结果可用，而是立即返回一个 `Future`对象，它将在未来某个时间完成时返回计算的值。

要执行异步计算，需要使用一个异步函数，该函数总是产生一个`Future`。在这样的异步函数中，可以使用 `wait` 操作延迟执行，直到另一个异步计算产生结果。当等待功能的执行被延迟时，程序不会被阻止，并且可以继续执行其他操作。

```Dart
Future<bool> textPrint(String str) async {
  var str1 = await Future.delayed(
    const Duration(seconds: 2),
    () {
      return str + "132";
    },
  );
  return str1.contains("123");
}
```

#### Future 对象的回调函数

有了`Future`，你可以手动注册回调，在值或错误可用时处理它。例如：

```Dart
Future<String> textPrint(String str) async {
  return Future.delayed(
    const Duration(seconds: 2),
    () {
      if (str.length == 0) {
        throw '参数不正确';
      } else {
        return "==" + str;  
      }
    },
  );
}


void main() async {
  print("======1");
  Future<String> future = textPrint("");
  future.then((res) {
    print("value ${res}");
  }, onError: (e) {
    if (e == "参数不正确") {
      print("以 <${e}, ${e.runtimeType}> 错误的方式表示执行成功"); 
    } else {
      return e;   // 如果不返回 e，则不会执行 catchError
    }
  }).catchError((error) {
    print("==22==${error.toString()}");
  });
  print("======2");
}

/* 执行结果：
======1
======2
以 <参数不正确, String> 错误的方式表示执行成功
*/
```

注册回调的结果本身就是一个 `Future`对象，它通过调用对应的回调和原始Future的结果来完成。如果被调用的回调抛出异常，新的future函数将以错误的方式完成。

##### then method

```Dart
Future<R> then<R>(FutureOr<R> onValue(T value), {Function? onError});
```

[then<R> method](https://api.dart.cn/stable/2.16.2/dart-async/Future/then.html)，向 `Future`对象注册完成时的回调函数。

* `onValue` 回调函数，当 `future` 函数用一个值完成时，`onValue`回调函数将用这个值被调用。如果这个`future`已经完成，回调不会立即被调用，而是会被调度到后面的微任务中。

* `onError`回调函数 (可选参数)，如果 `future` 函数以一个错误结束，那么将使用该错误及其堆栈跟踪调用`onError`回调函数。`OneError`回调函数必须接受一个参数或两个参数，其中前者为 `error`对象，后者是`StackTrace`。`OneError`回调函数必须返回一个 值或`future`

##### catchError method

```Dart
Future<T> catchError(Function onError, {bool test(Object error)?});
```

[catchError method](https://api.dart.cn/stable/2.16.2/dart-async/Future/catchError.html)回调函数 处理此`Future`发出的错误。

* 在大多数情况下，单独使用 `catchError` (可能带有一个测试参数)比在单个`then`调用中同时处理值和错误更具可读性。

* 如果`future`完成时出现错误，则首先使用错误值调用`test`。如果 `test` 返回 `true`, `onError` 将被调用。


#### 链式异步编程

then() 方法返回一个 Future 对象，这样就提供了一个非常好的方式让多个异步方法按顺序依次执行。如果用 then() 注册的回调返回一个 Future ，那么 then() 返回一个等价的 Future 。如果回调返回任何其他类型的值，那么 then() 会创建一个以该值完成的新 Future 。

```Dart
Future<String> addPrint(String str) async {
  return Future.delayed(
    const Duration(seconds: 1),
    () {
      return "加加${str}";
    },
  );
}

Future<String> reducePrint(String str) async {
  return Future.delayed(
    const Duration(seconds: 1),
    () {
      return "减减${str}";
    },
  );
}
```

链式执行异步函数

```Dart
void main() {
  Future<String> future = addPrint("1");
  future.then((res) {
    print(res);
    return reducePrint(res);
  }).then((res) {
    print(res);
    return addPrint(res);
  }).then((res) {
    print(res);
  });
}

// 等价于

void main() async {  
  var str1 = await addPrint("1");
  print(str1);
  var str2 = await reducePrint(str1);
  print(str2);
  var str3 = await addPrint(str2);
  print(str3);
}
```


#### `Future.wait` 等待多个 Future

有时代码逻辑需要调用多个异步函数，并等待它们全部完成后再继续执行。使用 Future.wait() 静态方法管理多个 Future 以及等待它们完成：

```Dart
Future<String> addPrint(String str) async {
  return Future.delayed(
    const Duration(seconds: 2),
    () {
      print("add = ${str}");
      return "加加${str}";
    },
  );
}

Future<String> reducePrint(String str) async {
  return Future.delayed(
    const Duration(seconds: 1),
    () {
      print("reduce = ${str}");
      return "减减${str}";
    },
  );
}

Future<void> textPrint(String str) async {
  return Future.delayed(
    const Duration(seconds: 2),
    () {
      print("===${str}");
    },
  );
}
```

```dart
void main() {
  Future.wait([addPrint("1"), reducePrint("1"), textPrint("1")]).then((res){
    print(res);
  });
}

// 等价于

void main() async {
  var res = await Future.wait([addPrint("1"), reducePrint("1"), textPrint("1")]);
  print(res);
}
```




