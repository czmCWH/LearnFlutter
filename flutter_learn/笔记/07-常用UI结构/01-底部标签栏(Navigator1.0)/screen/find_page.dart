import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin {

  // 缓存此 Widget，避免销毁
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    debugPrint("---- Find initState");
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("---- Find dispose");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("---- Find build");
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("发现"),
        ],
      ),
    );
  }
}