/*
  Map：https://api.dart.cn/stable/3.4.0/dart-core/Map-class.html
   
  map(映射)是 keys-values关联的对象。 keys 和 values 都可以是任何类型的对象。 
   每个 key 仅出现一次，相同的 value 可以使用多次。
   Dart 对 maps 提供 map literals 和 map type 的支持。 

 */
void main(List<String> args) {
  // 1、使用字面量方式创建 map
  var mp1 = {"s1": 1, "s2": 3};
  print("$mp1, ${mp1.runtimeType}");  // {s1: 1, s2: 3}, _Map<String, int>

  var mp2 = {1: 1, 2: 3};  
  print("$mp2, ${mp2.runtimeType}");  // {1: 1, 2: 3}, _Map<int, int>


  // 2、使用 Map 构造函数创建
  var saMp1 = Map<String, int>();
  saMp1['s1'] = 10;
  saMp1['s2'] = 20;
  print("saMp1 = $saMp1");     // 打印：saMp1 = {s1: 10, s2: 20}

  var saMp2 = <String, int>{};
  print("saMp2 = $saMp2, length = ${saMp2.length}");   // 打印：saMp2 = {}, length = 0
  saMp2["a"] = 10;
  print("saMp2 = $saMp2, length = ${saMp2.length}");   // 打印：saMp2 = {a: 10}, length = 1

  // 3、创建常量Map
  // 在 map literal 前面加 const 来创建 compile-time constant 的 map
  final constantMap = const {'s1': 10, 's2': 20};
  // constantMap[s1] = 100;     // 修改常量的值会报错。

  print('---------------------------------');
  saMp1['s1'] = 20; // 根据key赋值
  print('根据key获取值: saMp1 = ${saMp1['s1']}');  // saMp1 = 20

  var hasKey = saMp2['b'] == null;
  print('判断 Map 是否存在某个 key 的值: hasKey: $hasKey');    // 打印： true

  var hasKey2 = saMp2.containsKey('b');
  print('hasKey2 = $hasKey2');  // hasKey2 = false
  var hasValue = saMp2.containsValue(10);
  print('hasValue = $hasValue');  // hasValue = true

  int? value = saMp1.remove('s1');
  print('删除某个key, value = $value, saMp1 = $saMp1');  // value = 20, saMp1 = {s2: 20}

  saMp1.clear();
  print('--- 清空字典: saMp1 = $saMp1');  // saMp1 = {}

  print('---------------------------------');
  
  /*
   * 和 List 一样，Map 支持 spread operators (... 和 ...?) 【扩展操作符】以及 collection if 和 for 【条件运算】。
   */
  final smp = const {'s1': 10, 's2': 20};
  var smp1 = {"s3": 30, ...smp};
  print('smp1 = $smp1');   // 打印：{s3: 30, s1: 10, s2: 20}
    
  Map<String, int>? smp2;
  var smp3 = {"s3": 33, ...?smp2};
  print('smp3 = $smp3');   // 打印：{s3: 33}

  const res = true;
  var ifmp = {"23": "aa", if (res) "33": "bbb"};
  print('ifmp = $ifmp');     // 打印：{23: aa, 33: bbb}

  print('---------------------------------');

  // 遍历 Map

  print('使用 forEach 遍历: ');
  Map ages = {'zhangsan': 17, 'lisi': 18};
  ages.forEach((key, value) {
    print('key = $key, value = $value');
  });

  print('使用 for 遍历: ');
  for (var key in ages.keys) {
    print('key = $key, value = ${ages[key]}');
  }

  // 遍历 Map 生成另一个 Map 
  Map newMp = ages.map((key, value) {
    return MapEntry(key + '1', value + 2);
  });
  print('newMp = $newMp');    // 打印： newMp = {zhangsan1: 19, lisi1: 20}


}