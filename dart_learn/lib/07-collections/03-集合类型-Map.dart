/*
 * Map：https://api.dart.cn/stable/3.4.0/dart-core/Map-class.html
 * map(映射)是`keys-values`关联的对象。 `keys`和`values`都可以是任何类型的对象。 
 * 每个`key`仅出现一次，相同的`value`可以使用多次。
 * Dart 对 maps 提供 map literals 和 map type 的支持。 
 * 
 */
void testMap() {
  // 1、使用字面量方式创建 map
  var mp1 = {"s1": 1, "s2": 3};
  var mp2 = {1: 1, 2: 3};
  print("$mp1, ${mp1.runtimeType}; $mp2, ${mp2.runtimeType}");     // 打印：{s1: 1, s2: 3}, _Map<String, int>; {1: 1, 2: 3}, _Map<int, int>

  // 2、使用 Map 构造函数创建
  var saMp1 = Map<String, int>();
  saMp1['s1'] = 10;
  saMp1['s2'] = 20;
  print("saMp1 = $saMp1");     // 打印：saMp1 = {s1: 10, s2: 20}

  var saMp2 = <String, int>{};
  print(saMp2);   // 打印：{}

  saMp2["a"] = 10;
  print('saMp2 = $saMp2');      // 打印：saMp2 = {a: 10}

  print('判断 Map中是否存在某个key的值: ${saMp2['b'] == null}');    // 打印： true
  print('获取Map中键值对的数量: ${saMp2.length}');    // 打印：1

  // 3、创建常量Map
  // 在 map literal 前面加 const 来创建 compile-time constant 的 map
  final constantMap = const {'s1': 10, 's2': 20};
  // constantMap[s1] = 100;     // 修改常量的值会报错。
}

void testOperatorsMap() {
  /*
   * 和 List 一样，Map 支持 spread operators (... 和 ...?) 以及 collection if 和 for。
   */

  final mp = const {'s1': 10, 's2': 20};
  var mp1 = {"s3": 30, ...mp};
  print(mp1);   // 打印：{s3: 30, s1: 10, s2: 20}
    
  Map<String, int>? mpp;
  var mp2 = {"s3": 33, ...?mpp};
  print(mp2);   // 打印：{s3: 33}

  const res = true;
  var mp3 = {"23": "aa", if (res) "33": "bbb"};
  print(mp3);     // 打印：{23: aa, 33: bbb}
}