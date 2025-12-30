import 'package:flutter/material.dart';
import 'package:moke_xiecheng/api/header_util.dart';
import 'package:moke_xiecheng/model/search_model.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// 搜索接口
class SearchApi {
  
  static Future<SearchModel?> fetch(String text) async {
    var uri = Uri.parse("https://api.geekailab.com/uapi/ft/search?q=$text");
    final response = await http.get(uri, headers: hiHeaders());
    // 处理中文乱码
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyStr = utf8decoder.convert(response.bodyBytes);
    
    debugPrint(bodyStr);

    if (response.statusCode == 200) {
      var result = json.decode(bodyStr);
      SearchModel model = SearchModel.fromJson(result);
      model.keyword = text;
      return model;
    } else {

      // if (response.statusCode == 401) {      // 跳转到登录
      //   NavigatorUtil.goToLogin();
      //   return null;
      // } 
      throw Exception(bodyStr);
    }
  }
}