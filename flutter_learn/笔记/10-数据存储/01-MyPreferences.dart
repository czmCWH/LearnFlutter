/*
<https://docs.flutter.cn/cookbook/persistence/key-value>
<https://pub-web.flutter-io.cn/packages/shared_preferences>

--- 少量数据持久化

👉 1、shared_preferences 插件

  * 如果你要存储的键值集合相对较少，则可以用 shared_preferences 插件。不是为存储大量数据而设计的。
  * shared_preferences 插件只能用于基本数据类型： int、double、bool、string 和 List<String>。
  * 不能确保应用重启后数据仍然存在。
  * 它是异步的

使用：  
    flutter pub add shared_preferences
    
    import 'package:shared_preferences/shared_preferences.dart';

其它：
  - 敏感信息用 flutter_secure_storage。

 */
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyPreferences(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MyPreferences extends StatefulWidget {

  const MyPreferences({ Key? key }) : super(key: key);

  @override
  State<MyPreferences> createState() {
    return _MyPreferences();
  }
}

// 创建 State
class _MyPreferences extends State<MyPreferences> {

  double? dText;
  bool? bText;
  List<String>? strList;

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('shared_preferences 插件'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('存储 double: '),
                Text('$dText'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setDouble('price', 1.111);
                    debugPrint('--- 保存: 1.111');
                  },
                  child: const Text('保存'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      dText = prefs.getDouble('price');
                    });
                  },
                  child: const Text('获取'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('price');
                    debugPrint('--- 移除了');
                  },
                  child: const Text('移除'),
                ),
              ],
            ),
            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('存储 bool: '),
                Text('$bText'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    Random random = Random();
                    bool randomBool = random.nextBool();
                    prefs.setBool('on-off', randomBool);
                    debugPrint('--- 保存: $randomBool');
                  },
                  child: const Text('保存'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      bText = prefs.getBool('on-off');
                      debugPrint('--- 获取: $bText');
                    });
                  },
                  child: const Text('获取'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('on-off');
                    debugPrint('--- 移除了');
                  },
                  child: const Text('移除'),
                ),
              ],
            ),
            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('存储 List<String>: '),
                Text('${strList?.toString()}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setStringList('list', ['a', 'bb', 'ccc']);
                    debugPrint('--- 保存: String List');
                  },
                  child: const Text('保存'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    setState(() {
                      strList = prefs.getStringList('list');
                      debugPrint('--- 获取: $strList');
                    });
                  },
                  child: const Text('获取'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('list');
                    debugPrint('--- 移除了');
                  },
                  child: const Text('移除'),
                ),
              ],
            ),
            const SizedBox(height: 20,),
          ],
        ),
      )
    );
  }

}
