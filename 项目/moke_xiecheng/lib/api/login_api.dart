import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';
import 'package:http/http.dart' as http;
import 'header_util.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';


/// 登录接口
class LoginDao {
  static const boardingPass = 'boarding_pass';

  static login({required String userName, required String password}) async {
    Map<String, String> params = {
      'userName': userName,
      'password': password,
    };

    var uri = Uri.https('api.devio.org', '/uapi/user/login', params);
    final response = await http.post(uri, headers: hiHeaders());
    // 解决返回数据中文乱码
    Utf8Decoder utf8decoder = const Utf8Decoder();  
    String bodyString = utf8decoder.convert(response.bodyBytes);
    debugPrint('--- 请求结果 = $bodyString');
    if (response.statusCode == 200) {
      var result = json.decode(bodyString) as Map<String, dynamic>;
      if (result['code'] == 0 && result['data'] != null) {
        _saveBoardingPass(result['data']);
      } else {
        throw Exception(bodyString);
      }
    } else {
      throw Exception(bodyString);
    }
  }

  // 保存登录令牌
  static void _saveBoardingPass(String value) {
     HiCache.getInstance().setString(boardingPass, value);
  }

  // 获取登录令牌
  static String? getBoardingPass() {
    return HiCache.getInstance().get(boardingPass);
  }

  /// 登出
  static void logOut() {
    // 移除登录信息
    HiCache.getInstance().remove(boardingPass);
    NavigatorUtil.goToLogin();
  }

}