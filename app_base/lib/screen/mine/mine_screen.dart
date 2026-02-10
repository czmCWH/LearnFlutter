import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../store/user_state_model.dart';

class MineScreen extends StatefulWidget {
  const MineScreen({super.key});

  @override
  State<MineScreen> createState() => _MineScreenState();
}

class _MineScreenState extends State<MineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mine-页面"),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 30,
          children: <Widget>[
            Consumer<UserStateModel>(
              builder: (BuildContext context, UserStateModel model, Widget? child) {
                return Text(
                  '用户 token = ${model.accessToken}',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<UserStateModel>().login();
                  },
                  child: const Text('点击登录'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<UserStateModel>().logout();
                  },
                  child: const Text('退出登录'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}