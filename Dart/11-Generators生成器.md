# 生成器

当你需要延迟地生成一连串的值时，可以考虑使用 `生成器函数`。`Dart` 内置支持两种形式的生成器方法：

* 同步生成器：返回一个 `Iterable` 对象。

* 异步生成器：返回一个 `Stream` 对象。


## 同步生成器

过在函数上加 `sync*` 关键字并将返回值类型设置为 [Iterable](https://api.dart.cn/stable/2.16.2/dart-core/Iterable-class.html) 来实现一个 `同步生成器函数`，在函数中使用 `yield` 语句来传递值。

```Dart
Iterable<int> getNumList(int maxValue) sync* {
  int i = 0;
  while(i < maxValue) yield i++;
}

Iterable<int> numIterable = getNumList(10);
print(numIterable);
List<int> numList = numIterable.toList();
print(numList);
```


## 异步生成器

实现 异步生成器函数与同步类似，只不过关键字为 `async*` 并且返回值为 `Stream`：

```Dart
Stream<int> getAsyncNumList(int maxValue) async* {
  int i = 0;
  while(i < maxValue) yield i++;
}

await for (var item in getAsyncNumList(6)) {
    print(item);
}
```

如果生成器是递归调用的，可是使用 `yield*` 语句提升执行性能：

```Dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1);
  }
}
```