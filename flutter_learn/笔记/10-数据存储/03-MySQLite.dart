/*
<https://docs.flutter.cn/cookbook/persistence/sqlite>
<https://pub-web.flutter-io.cn/packages/sqflite>
<https://www.sqlitetutorial.net/>

--- sqlite 数据库存储

如果你正在编写一个需要持久化且查询大量本地设备数据的 app，可考虑采用数据库，而不是本地文件夹或关键值库。
总的来说，相比于其他本地持久化方案来说，数据库能够提供更为迅速的插入、更新、查询功能。

👉 1、sqflite package
sqflite package 来使用 SQLite 数据库。仅支持 macOS、iOS 和 Android。
为了使用 SQLite 数据库，首先需要导入 sqflite 和 path package。

使用：
    flutter pub add sqflite path

    import 'package:sqflite/sqflite.dart';
    import 'package:path/path.dart';

  * sqflite 提供了丰富的类和方法，以便你能便捷实用 SQLite 数据库。
  * path 提供了大量方法，以便你能正确的定义数据库在磁盘上的存储位置。



 */

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    WidgetsFlutterBinding.ensureInitialized();

    return const MaterialApp(
      home: MySQLite(),
      debugShowCheckedModeBanner: false,   
    );
  }
}

class MySQLite extends StatefulWidget {

  const MySQLite({ Key? key }) : super(key: key);

  @override
  State<MySQLite> createState() {
    return _MySQLite();
  }
}

class _MySQLite extends State<MySQLite> {

  Future<Database> get dataBase async {
    // 1、打开数据库并获取引用
    return openDatabase(
      // 设置数据库路径
      join(await getDatabasesPath(), 'doggie_database.db'),
      // 当数据库第一次创建时，创建一张表存储 Dog 实例
      onCreate: (db, version) {
        return db.execute('CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',);
      },
      version: 1,
    );
  }

  Database? dbBase;
  var _counter = 0;

  @override
  void dispose() {
    // 关闭数据库
    dbBase?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航栏'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              _counter += 1;
              final dg = Dog(id: _counter, name: '狗子$_counter', age: _counter*2);
              await insertDog(dg);
              debugPrint('--- 增加数据 = ${dg.toString()}');
            }, 
            child: const Text('增加数据'),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {
              final dg = Dog(id: _counter, name: '狗子${_counter+100}', age: _counter*3);
              await updateDog(dg);
              debugPrint('--- 修改数据 = ${dg.toString()}');
            }, 
            child: const Text('修改数据'),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {
              final dgList = await dogsData();
              for (final dg in dgList) {
                debugPrint(dg.toString());
              }
            }, 
            child: const Text('查询数据'),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {
              if (_counter == 0) {
                debugPrint('--- 已经全部删除了');
                return;
              }
              await deleteDog(_counter);
              debugPrint('--- 删除数据 = $_counter');
              _counter -= 1;
            }, 
            child: const Text('删除数据'),
          ),
        ],
      ),
    );
  }


  // 1、插入一条数据
  Future<void> insertDog(Dog dog) async {
    var db = await dataBase;
    dbBase = db;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, // 在同一条数据被插入两次时进行替换。
    );
  }

  // 2、查询所有数据
  Future<List<Dog>> dogsData() async {
    var db = await dataBase;
    dbBase = db;
    final List<Map<String, Object?>> dogMaps = await db.query('dogs');
    return [ for (final obj in dogMaps) Dog(id: obj['id'] as int, name: obj['name'] as String, age: obj['age'] as int),];
  }

  // 3、修改数据
  Future<void> updateDog(Dog dog) async {
    var db = await dataBase; 
    dbBase = db;
    await db.update(
      'dogs',
      dog.toMap(),
      // 根据 ID 匹配 去更新
      where: 'id = ?',
      // P将 Dog 的 id 作为 whereArg 传递以防止 SQL 注入。
      whereArgs: [dog.id],
    );
  }

  // 4、删除指定 ID 的数据
  Future<void> deleteDog(int id) async {
    var db = await dataBase; 
    dbBase = db;
    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}


class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({ required this.id, required this.name, required this.age, });

  // 将模型转换为 Map，其 key 必须和数据库中的相对应
  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age, };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}