import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class StatefulShellRouteScaffold extends StatelessWidget {

  const StatefulShellRouteScaffold({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Section A'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Section B'),
          BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Section C'),
        ],
        currentIndex: navigationShell.currentIndex,
        // Navigate to the current location of the branch at the provided index
        // when tapping an item in the BottomNavigationBar.
        onTap: (int index) => navigationShell.goBranch(index),
      ),
    );
  }

  // ignore: unused_element
  // void _onTap(BuildContext context, int index) {
  //   navigationShell.goBranch(
  //     index,
  //     initialLocation: index == navigationShell.currentIndex,
  //   );
  // }
}