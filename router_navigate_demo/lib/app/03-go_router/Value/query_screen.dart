import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QueryScreen extends StatefulWidget {

  final String? desc;

  const QueryScreen({super.key, this.desc});

  @override
  State<QueryScreen> createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  @override
  Widget build(BuildContext context) {
    
    final query1 = GoRouterState.of(context).uri.queryParameters['desc'];
    debugPrint("--- 接收查询参数，desc = $query1");

    return Scaffold(
      appBar: AppBar(title: Text("接收 Query 查询参数"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("接收参数，desc = ${widget.desc}"),
          ],
        ),
      ),
    );
  }
}