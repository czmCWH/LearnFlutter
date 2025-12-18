import 'package:flutter/material.dart';

// --- ListView.separated 构建带分割线列表

class MyListViewSeparated extends StatelessWidget {
  const MyListViewSeparated({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {    // itemBuilder 用于构建列表项
        return Container(
          color: Colors.blue,
          height: 100,
          child: Center(
            child: Text("第${index + 1}个", style: const TextStyle(color: Colors.white, fontSize: 25),),
          ),
        );
      }, 
      separatorBuilder: (BuildContext context, int index) { 
        return Container(color: Colors.red, height: 20,);
      }, 
      itemCount: 20
     );
  }
}
