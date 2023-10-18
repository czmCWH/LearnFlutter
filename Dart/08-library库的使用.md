# Dart 库

## 库和可见性

`import` 和 `library` 指令可以用来创建一个模块化的、可共享的代码库。 库不仅提供了 API ，而且对代码起到了封装的作用： 以下划线 `(_)` 开头的标识符仅在库内可见。 每个 `Dart`程序都是一个库 ，即使它没有使用 `library` 指令。

可以使用 [packages](https://dart.dev/guides/packages) 分发库。

### 使用库

使用 `import` 来指定命名空间以便其它库可以访问。

例如，`Dart Web`应用程序通常使用[dart:html](https://api.dart.dev/stable/dart-html)库，可以像这样导入：

```Dart
import 'dart:html';
```

`import` 的唯一参数是用于指定代码库的 URI，URI代表统一资源标识符。

对于 Dart 内置库，URI具有特殊的 `dart: scheme`。 对于其他库，可以使用系统文件路径或 `package: scheme`。`package: scheme`指定由包管理器（例如pub工具）提供的库。 例如：

```Dart
import 'package:test/test.dart';
```

### as 指定库前缀

如果导入两个标识符冲突的库，则可以为一个或两个库指定一个前缀。例如，如果library1和library2都具有Element类，那么您可能具有以下代码：

```Dart
import 'package:lib1/lib1.dart';
import 'package:lib2/lib2.dart' as lib2;

// Uses Element from lib1.
Element element1 = Element();

// Uses Element from lib2.
lib2.Element element2 = lib2.Element();
```

### 导入库的一部分

如果只想使用一部分库，则可以有选择地导入该库。例如：

```Dart
// Import only foo.
import 'package:lib1/lib1.dart' show foo;

// Import all names EXCEPT foo.
import 'package:lib2/lib2.dart' hide foo;
```

### 延迟加载库

`Deferred loading`（也称为 `lazy loading`）允许`Web app`在需要库的时候按需加载库。 在某些情况下，您可能会使用延迟加载：

* 减少`Web app`的初始启动时间。
* 执行A/B测试，例如，尝试各种算法的 不同实现。
* 加载很少使用的功能，例如可选的屏幕和对话框。 

> 仅 `dart2js` 支持延迟加载。 Flutter，Dart VM 和 dartdevc 不支持延迟加载。

使用 `deferred as` 关键字来标识需要延时加载的代码库：

```Dart
import 'package:greetings/hello.dart' deferred as hello;
```

当您需要该库时，请使用库的标识符调用`loadLibrary()`。

```Dart
Future greet() async {
  await hello.loadLibrary();
  hello.printGreeting();
}
```

上面代码中，`await` 关键字将暂停执行，直到加载该库为止。

可以在一个库上多次调用`loadLibrary()`，该库仅加载一次。

使用延迟加载时，请注意以下几点：

* 延迟库的常量不是导入文件中的常量。 请记住，在加载延迟的库之前，这些常量是不存在的。
* 在导入文件的时候无法使用延迟库中的类型。 如果你需要使用类型，则考虑把接口类型移动到另外一个库中， 让两个库都分别导入这个接口库。
* Dart 隐含的把 loadLibrary() 函数导入到使用 deferred as 的命名空间 中。 loadLibrary() 方法返回一个 Future。


