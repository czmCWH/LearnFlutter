import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/foundation.dart' show debugPrint;

void log(String? msg, {int? wrapWidth}) {
  if (kDebugMode) {
    debugPrint(msg, wrapWidth: wrapWidth);
  }
}