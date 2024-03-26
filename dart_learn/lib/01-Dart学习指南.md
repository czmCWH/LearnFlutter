# 一、Dart 概述

[Dart 编程语言概览 * 中文](https://dart.cn/overview)

[Dart 概述 * 英文](https://dart.dev/overview)

[DartPad](https://dart.dev/tools/dartpad)，浏览器中体验 Dart 编程语言线上工具。

Dart 也是 Flutter 的基础。 Dart 作为 Flutter 应用程序的编程语言，为驱动应用运行提供了环境，同时 Dart 还支持许多核心的开发任务，例如格式化，分析和代码测试。

Dart 语言是类型安全的；它使用静态类型检查来确保变量的值 始终 与变量的静态类型相匹配。
尽管类型是强制性的，但由于 Dart 支持类型推断，类型注释仍是可选的。
Dart 的类型系统也很灵活，允许结合使用 dynamic 类型与运行时检查，在测试开发期间，或是遇到需要特别指定为动态类型的代码时，这项特性很有帮助。
Dart 内置了 健全的空值安全，这意味着只有你声明值可以为空的情况下，值才可以为空；
Dart 拥有 丰富的核心库，为许多日常编程任务提供了必要工具；

# 二、安装 Dart

要使用 Dart，可以直接下载 Dart SDK（如下所述），也可以下载 Flutter SDK，其中包含完整的 Dart SDK。

使用 [Homebrew](https://brew.sh/) 安装 Dart：

```dart
// 安装 Dart
$ brew tap dart-lang/dart
$ brew install dart

// 查看 Dart 版本号
$ dart --version
```


# 三、创建 Dart 命令行应用

```dart
// 创建 dart 命令行应用
$ dart create dart_learn
$ cd dart_learn

// 运行 dart 命令行应用
$ dart run 
```