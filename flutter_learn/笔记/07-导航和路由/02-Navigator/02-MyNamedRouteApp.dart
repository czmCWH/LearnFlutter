import 'package:flutter/material.dart';

/*
--- Navigator 组件 - 命名路由
使用步骤：
  1、在 MaterialApp 组件中配置 routes 路由表 和 initialRoute 初始路由（作为App首页）。
  2、使用 Navigator 命令式 API 进行路由：
    Navigator.pushNamed(...)，进入新页面
    Navigator.pushReplacementNamed(...)，替换当前页面
    Navigator.pushNamedAndRemoveUntil(...)，跳转新页面并清理栈
    Navigator.popAndPushNamed(...)，返回并立即跳转新页面
    Navigator.popUntil(...)，连续返回直到满足条件
  3、跳转时传递参数，直接在 pushNamed 中传递即可。
 */


class MyNamedRouteApp extends StatelessWidget {
  const MyNamedRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "浏览器标题",
      // 1、注册路由表
      routes: {
        "/list": (context) => const MyListPage(),
        "/detail": (context) => const MyDetailPage(),
      },
      // 2、onGenerateRoute 实现路由拦截
      onGenerateRoute: (settings) {
        print("--- 路由名称 ${settings.name}");
        print("--- 路由参数 ${settings.arguments}");
        if (settings.name == '/list') {
          return MaterialPageRoute(builder: (context) => const MyListPage());
        }
      },
      // 3、拦截未在 路由表中注册、也未在 onGenerateRoute 中处理的路由，会调用此回调。
      onUnknownRoute: (settings) {

      },
      initialRoute: "/list",    // initialRoute 设置初始路由
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
        title: const Text('Navigator 组件 - 命名路由'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // if (index%2 == 0) {
              //   Navigator.pushNamed(context, "/other");
              // } else {
                Navigator.pushNamed(
                  context, "/detail", 
                  arguments: {
                    "id": index + 1
                  }
                );
              // }
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


class MyDetailPage extends StatefulWidget {
  const MyDetailPage({super.key});

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {

  String _id = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 接收路由参数
    // initState 中 获取不到路由参数，需在 Future.microtask 异步微任务中获取。
    Future.microtask(() {
      if (ModalRoute.of(context) != null) {
         Map<String, dynamic> params = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
         print(params["id"]);
         _id = params["id"].toString();
         setState(() {
           
         });
      } else {
         debugPrint("--- 没有获取到参数");
      }
    });

  }

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
              child: Text("去列表页$_id"),
            ),
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


class MyOtherPage extends StatelessWidget {
  const MyOtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("其它页"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("我是其它页", style: TextStyle(color: Colors.black, fontSize: 30),),
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