import 'package:flutter/material.dart';
import 'package:moke_xiecheng/api/header_util.dart';
import 'package:moke_xiecheng/model/home_model.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// 首页大接口
class HomeApi {

  static Future<HomeModel?> fetch() async {
    var url = Uri.parse('https://api.geekailab.com/uapi/ft/home');
    final response = await http.get(url, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();  // 用于解决中文乱码
    String bodyString = utf8decoder.convert(response.bodyBytes);
    debugPrint('--- bodyString = $bodyString');
    if (response.statusCode == 200) {
      var result = json.decode(bodyString) as Map<String, dynamic>;
      return HomeModel.fromJson(result);
    } else {
      // if (response.statusCode == 401) {
      //   NavigatorUtil.goToLogin();
      //   return null;
      // }
      throw Exception(bodyString);
    }
  }
}