import 'package:flutter/foundation.dart';
import '../model/user.dart';

class UserStateModel with ChangeNotifier {
  User? _user;
  String? _accessToken;

  User? get user => _user;
  String? get accessToken => _accessToken;
  bool get isLoggedIn => _user != null && _accessToken != null;

  void login() {
    _accessToken = "已登录";
    notifyListeners(); // 通知监听者重建
  }

  void logout() {
   _accessToken = null;
    notifyListeners();
  }
}