import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class MyRouteParser extends RouteInformationParser<String> {
  @override
  Future<String> parseRouteInformation(RouteInformation routeInformation) {
    final location = routeInformation.location;
    return SynchronousFuture(location);
  }

  @override
  RouteInformation restoreRouteInformation(String configuration) {
    return RouteInformation(location: configuration);
  }
}