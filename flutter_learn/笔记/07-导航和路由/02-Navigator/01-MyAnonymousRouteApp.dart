import 'package:flutter/material.dart';

/*
 --- Navigator 组件 - 匿名路由
 使用步骤：
    1、Navigator.push，跳转新页面，需创建一个 MaterialPageRoute 实例传递。
    2、Navigator.pop，返回上一个页面。
    3、参数传递，与父子组件传递一致，即：页面定义 final 参数，通过构造函数接收。

 */


class MyAnonymousRouteApp extends StatelessWidget {
  const MyAnonymousRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,   
      home: const MyListPage(),
    );
  }
}

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigator 组件 - 匿名路由'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MyDetailPage()));
            },
            child: Container(
              color: Colors.blue,
              height: 100,
              margin: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Text(
                "列表${index+1}",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          );
        }
      ),
    );
  }
}


class MyDetailPage extends StatelessWidget {
  const MyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("详情页"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("返回上一页")
            ),
          ],
        ),
      ),
    );
  }
}