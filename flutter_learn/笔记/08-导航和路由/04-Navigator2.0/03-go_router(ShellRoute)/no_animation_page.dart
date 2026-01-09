import 'package:flutter/material.dart';

class NoAnimationMaterialPage<T> extends MaterialPage<T> {
  const NoAnimationMaterialPage({
    required super.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
      transitionDuration: Duration.zero,
    );
  }
}