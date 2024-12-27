# 一、Dart 概述

[Dart 编程语言概览 * 中文](https://dart.cn/)

[Dart 概述 * 英文](https://dart.dev/overview)

[DartPad](https://dart.dev/tools/dartpad)，浏览器中体验 Dart 编程语言线上工具。

Dart 语言是类型安全的；它使用静态类型检查来确保变量的值 始终 与变量的静态类型相匹配。这也叫健全类型。
尽管类型是强制性的，但由于 Dart 支持类型推断，类型注释仍是可选的。
Dart 的类型系统也很灵活，允许结合使用 dynamic 类型与运行时检查，在测试开发期间，或是遇到需要特别指定为动态类型的代码时，这项特性很有帮助。
Dart 内置了 健全的空值安全，这意味着只有你声明值可以为空的情况下，值才可以为空；
Dart 拥有 丰富的核心库，为许多日常编程任务提供了必要工具；

* 可详细阅读 Dart 概览：<https://dart.cn/overview>

* 学习视频：https://ducafecat.com/course/dart-learn

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

<https://dart.cn/tutorials/server/get-started>

```dart
// 创建 dart 命令行应用
$ dart create dart_learn
$ cd dart_learn

// 运行 dart 命令行应用
$ dart run 
```

该命令会创建一个包含下述信息的 Dart 应用：

* 一个主要的 Dart 源文件，`bin/dart_learn.dart`，该文件包含一个顶层 `main()` 函数。该函数是你应用的入口。
* 一个额外的 Dart 文件，`lib/xxx.dart`，包含一些功能性的函数方法，这些函数方法将会导入到 `dart_learn.dart` 文件中。
* 一个 pubspec 文件，pubspec.yaml，包含应用的元数据，包括应用依赖的 package 信息以及所需的版本等。


# 四、学习

可以学习高效指南 (Effective Dart) <https://dart.cn/effective-dart/>，提高开发技巧。

