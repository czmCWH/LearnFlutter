import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReturnScreen extends StatefulWidget {
  const ReturnScreen({super.key});

  @override
  State<ReturnScreen> createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen> {
  int _count = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("pop回传参数"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            GestureDetector(
              child: Text("data = $_count", style: TextStyle(fontSize: 20),),
              onTap: () {
                setState(() {
                  _count++;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.pop(_count);
              }, 
              child: Text("pop 直接回传参数")
            ),

            ElevatedButton(
              onPressed: () {
                final notifier = GoRouterState.of(context).extra as ValueNotifier<int?>;
                notifier.value = _count;
                context.pop();
              }, 
              child: Text("修改 ValueNotifier 类型的 extra 参数回传"),
            ),

            ElevatedButton(
              onPressed: () {
                final callBack = GoRouterState.of(context).extra as ValueChanged<int?>;
                callBack(_count);
                context.pop();
              }, 
              child: Text("修改 Function 类型的 extra 参数回传"),
            ),
          ],
        ),
      ),
    );
  }
}