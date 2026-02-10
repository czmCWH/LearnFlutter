import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category-页面"),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 30,
          children: <Widget>[
            const Text('Screen B'),
            GestureDetector(
              onTap: () {
                setState(() {
                  _count++;
                });
              },
              child: Text("数据：$_count", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/b/details');
                // GoRouter.of(context).push('/a/details');
              },
              child: const Text('View B details'),
            ),
          ],
        ),
      ),
    );
  }
}