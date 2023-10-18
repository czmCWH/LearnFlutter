# 一、Dart概述

`Dart`是`Flutter`的基础，`Dart` 提供了支持 `Flutter` 应用程序的语言和运行时，但`Dart`还支持许多核心开发人员任务，例如格式化，分析和测试代码。

`Dart`是类型安全的，它使用静态类型检查来确保变量的值始终与变量的静态类型匹配。 有时，这被称为`sound typing`。尽管类型是强制性的，但由于类型推断，类型注释是可选的。 `Dart`类型系统也很灵活，允许将动态类型 与 运行时检查结合使用，这在 实验期间 或 需要特别动态的代码中 很有用。

`Dart` 提供可靠的空值安全性，这意味着值不能为空，除非你说他们可以。 凭借可靠的`null`安全性，`Dart`可以通过静态代码分析在运行时保护你免受`null`异常的影响。与许多其他 `null-safe` 语言不同，`Dart`确定变量是不可为空时，该变量始终是不可为空的。

```Dart
void printInteger(int aNumber) {
  print("==czm==$aNumber");
}

void main() {
  var num = 34;
  printInteger(num);    // 打印：34
}
```

## 重要概念

* `main` 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。

* `Dart` 所有变量引用的都是 对象，每个对象都是一个 类 的实例。数字、函数以及 `null` 都是对象。除去 `null` 以外（如果你开启了 `Null safety`(空安全)）, 所有的类都继承于 `Object` 类。

* 尽管 `Dart` 是强类型语言，但是在声明变量时指定类型是可选的，因为 `Dart` 可以进行类型推断。

* 如果你开启了 `Null safety`(空安全)，变量在未声明为可空类型时不能为 `null`，除非你说可以，通过在变量类型的末尾添加 `?` 来使该变量可为空。

```Dart
// 未开启 Null safety 时，
var num = null;
print("---${num}");         // 打印：---null

// 开启 Null safety 时
int? num = null;
print("---${num}");         // 打印：---null

var num = null;
print("---${num}");         // 将抛出异常
```

* 显式地声明允许任意类型，使用 `Object?`(如果你开启了 `Null safety`(空安全))、`Object`；如果必须将类型检查推迟到运行时，则用特殊类型`dynamic`。

```Dart
Object? num = null;
num = "abc";
num = 22;
print("---${num}");
```

* `Dart`支持`top-level`函数(如：`main()`) 以及与类或对象绑定的函数(分别为静态方法和实例方法)。还可以在函数（嵌套或局部函数）中创建函数。

* 同样，`Dart`支持`top-level`顶级 变量，以及定义属于类或对象的变量（静态和实例变量）。实例变量有时称之为域或属性。

* `Dart`支持泛型，如下定义存储整数的列表

```Dart
List<int> arr = [1, 2, 3];
print('$arr');
```

* `Dart` 没有类似于 `Java` 那样的 `public`、`protected` 和 `private` 成员访问限定符。如果一个标识符以下划线 (`_`) 开头则表示该标识符在库内是私有的。

* 标识符可以以字母或下划线（_）开头，然后是这些字符加数字的任意组合。

* `$variableName` (或 `${expression}`)，表示字符串插值：字符串字面量中包含的变量或表达式。

* `Dart` 中没有非0即真 或 非空即真。

* `Dart` 不支持函数重载！（函数重载：函数名称相同，参数不同）

* `void` 一种特殊的类型，表示一个值永远不会被使用。以 `void` 声明的函数返回类型，并不会返回值。


## 开源库

[flutterchina/dio](https://github.com/flutterchina/dio)，9.3k，Dart的功能强大的Http客户端，它支持拦截器，FormData，请求取消，文件下载，超时等。

[microsoft/FluentDarkModeKit](https://github.com/microsoft/FluentDarkModeKit)，1.5k，用于在iOS中向后移植黑暗模式的库。

## 学习路径

[Dart 概述 * 英文](https://dart.dev/overview)

[Dart 编程语言概览 * 中文](https://dart.cn/guides/language/language-tour)

[DartPad](https://dart.dev/tools/dartpad)

[SunshineBrother/FlutterDemo](https://github.com/SunshineBrother/FlutterDemo)，flutter初学项目