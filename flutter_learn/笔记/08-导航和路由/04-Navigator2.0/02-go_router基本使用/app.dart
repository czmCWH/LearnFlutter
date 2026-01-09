import 'package:flutter/material.dart';
import 'app_router.dart';

class App extends StatefulWidget {
  const App({super.key});

  get currentState => null;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      title: "Navigator2.0 - go_router",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppRouter().router,
    );
  }
}

