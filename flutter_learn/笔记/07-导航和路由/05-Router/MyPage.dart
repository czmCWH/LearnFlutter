import 'package:flutter/material.dart';
import 'MyHomePage.dart';

class MyPage extends Page {

  const MyPage({
    LocalKey? key,
    String? name,
  }) : super(key: key, name: name);


  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return MyHomePage(title: 'Route: $name');
      },
    );
  }
}
