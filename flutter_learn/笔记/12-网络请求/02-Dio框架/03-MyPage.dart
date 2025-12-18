import 'package:flutter/material.dart';
import '02-DioUtils.dart';
import 'package:dio/dio.dart';

// --- 使用 Dio 框架发送网络请求

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  List<Map<String, dynamic>> _list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 发送网络请求
    _getChannels();
  }

  void _getChannels() async {
    DioUtils dioTool = DioUtils();
    Response<dynamic> result = await dioTool.get("channels");
    Map<String, dynamic> res = result.data as Map<String, dynamic>;
    List data = res["data"]["channels"] as List;
    print(data);
    _list = data.cast< Map<String, dynamic>>() as List<Map<String, dynamic>>;
    print(_list);
    setState(() {
      
    });

  }

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      padding: const EdgeInsets.all(5),
      mainAxisSpacing: 10,
      crossAxisSpacing: 15,
      maxCrossAxisExtent: 140,
      children: List.generate(_list.length, (int index) {
        return ChannelItem(
          item: _list[index],
          delItem: (item) {
            // ⚠️，父级接收子级参数
            _list.remove(item);
            setState(() {
              
            });
          },
        );
      }),
    );
  }
}

class ChannelItem extends StatelessWidget {

  final Map<String, dynamic> item;
  // ⚠️，定义回调函数向父级传递参数
  final Function(Map<String, dynamic> item) delItem;

  const ChannelItem({super.key, required this.item, required this.delItem});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(item["name"] ?? "空", style: const TextStyle(color: Colors.white, fontSize: 18),),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: () {
              delItem(item);
            }, 
            icon: const Icon(Icons.delete, color: Colors.red,)
          ),
        ),
      ],
    );
  }
}