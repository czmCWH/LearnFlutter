import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenC extends StatelessWidget {
  /// Constructs a [ScreenC] widget.
  const ScreenC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("C 页面"),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 30,
          children: <Widget>[
            const Text('Screen C'),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/c/details');
              },
              child: const Text('View C details'),
            ),
          ],
        ),
      ),
    );
  }
}