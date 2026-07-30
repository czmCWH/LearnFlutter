import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/person.dart';
import '../model/student.dart';

/*
  1、Getx 响应式数据 + Obx 实现UI渲染。
 */
class COneScreen extends StatelessWidget {

  COneScreen({super.key});

  // 1、直接声明响应式变量
  final RxInt _count = 0.obs;
  final RxString _username = "张三".obs;
  final RxList _list = ["张三", "李四"].obs;
  
  // 2、把类的属性转换为响应式
  var p = Person();

  // 3、将整个类转换为一个可观察的类
  final st = Student("学生", 10).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("C-One-页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [
            // 使用 响应式数据渲染需要通过 Obx 
            Obx(() => Text("${_count.value}", style: TextStyle(fontSize: 18),)),
            
            Obx(() {
              return Text(_username.value, style: TextStyle(fontSize: 15),);
            }),
            
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: _list.map((v) {
                  return Text(v);
                }).toList(),
              );
            }),

            Obx(() {
              return Text("Person 名字 = ${p.name.value}, 年龄 = ${p.age.value}", style: TextStyle(color: Colors.red),);
            }),

            Obx(() {
              return Text("Student 名字 = ${st.value.name}, 年龄 = ${st.value.age}", style: TextStyle(color: Colors.blue),);
            }),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 1、直接更新响应式变量
          _count.value++;
          _username.value = "zhangsan";
           debugPrint(_list.toString());
          if (_list.lastIndexOf("王五") == -1) {
            _list.add("王五");
          }

          // 2、更新类的响应式属性
          p.name.value = p.name.value + _count.toString();

          // 3、更新响应式类
          st.update((student) {
            student?.name = st.value.name + _count.toString();
          });

        },
      ),
    );
  }
}