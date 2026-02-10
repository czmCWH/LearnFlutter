import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import '../../l10n/app_localizations.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Home-页面"),),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 30,
          children: <Widget>[
            const Text('Screen A'),
            TextButton(
              onPressed: () {
                // GoRouter.of(context).go('/home/detail');
                debugPrint("${AppLocalizations.of(context)?.helloWorld}");
              },
              child: const Text('View A details'),
            ),
          ],
        ),
      ),
    );
  }
}