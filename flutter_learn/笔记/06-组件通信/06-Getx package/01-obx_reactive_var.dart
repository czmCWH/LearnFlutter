import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

/// 把一个变量声明为响应式变量，使用 Obx Widget 监听任意类型的变量
class MyObxReactivePage extends StatelessWidget {

  // 方式一：Rx{Type}
  final name = RxString('');
  final isLogged = RxBool(false);

  // 方式二：泛型 Rx<Type>
  final count = Rx<int>(0);
  final balance = Rx<double>(0.0);

  // 方式三：只需添加 .obs 作为value的属性。更实用、更简单、更可取，推荐使用！！！
  final items = <String>[].obs;
  final myMap = <String, int>{}.obs;

  // 响应式类
  final rxUser = _RxUser();
  final user = _User(name: "张三", age: 18).obs;

  MyObxReactivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Obx Widget 响应式状态管理'),),
      body: Center(
        child: Obx(() => Column(    // Obx Widget 订阅响应式变量并监听变化来更新
          children: [
            const Spacer(),
            Text(name.value),
            Switch(
              value: isLogged.value, 
              onChanged: (res) {
                debugPrint('--- res');
              },
            ),

            Text('int 值为: $count'),
            Text('double 值为: $balance'),
            Text('List<String>的值为: ${items.toString()}'),
            Text('Map<String, int>的值为：${jsonEncode(myMap)}'),

            ElevatedButton(
              onPressed: () {
                name.value = '好好学习，天天向上';
                isLogged.value = !isLogged.value;
                count.value += 1;
                balance.value = 3.111111;

                // 注意：使用 List 时，不需要带上.value。而对于 String、int、bool 则需要带上.value。
                items.add('${count.value}');
                myMap['key'] = 22222;
              }, 
              child: const Text('更新值')
            ),

            const Spacer(),
            Text('RxUser: name = ${rxUser.name.value}, age = ${rxUser.age.value}'),
            ElevatedButton(
              onPressed: () {
                rxUser.name.value = '李四';
                rxUser.age.value += 1;
              }, 
              child: const Text('更新类的 响应式属性'),
            ),
            
            Text('User: name = ${user.value.name}, age = ${user.value.age}'),
            ElevatedButton(
              onPressed: () {
                // 注意！！！，这种方式无法更新状态
                user.value.name = '方式1';
                user.value.age += 1;
              }, 
              child: const Text('更新响应式类,方式1'),
            ),
            ElevatedButton(
              onPressed: () {
                user.update((user) {
                  user?.name = '方式2';
                  user?.age += 1;
                });
              }, 
              child: const Text('更新响应式类, 方式2'),
            ),
            ElevatedButton(
              onPressed: () {
                user(_User(name: '方式3', age: 22));
              }, 
              child: const Text('更新响应式类,方式3'),
            ),
            const Spacer(flex: 2,),
          ],
        )),
      )
    );
  }
}

/// 1、把类的属性定义为响应式
class _RxUser {
  final name = ''.obs;
  final age = 0.obs;
}
/// 2、在实例化时将整个类转换为一个可观察的类。
/// final user = User(name: "Camila", age: 18).obs;
class _User {
  String name;
  int age;

  _User({required this.name, required this.age});
}