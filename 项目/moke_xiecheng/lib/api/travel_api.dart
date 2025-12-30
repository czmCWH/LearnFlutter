import 'package:flutter/material.dart';
import 'package:moke_xiecheng/api/header_util.dart';
import 'package:moke_xiecheng/model/travel_tab_model.dart';
import 'package:moke_xiecheng/model/travel_category_model.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// 旅拍分类请求接口
class TravelApi {

  /// 获取旅拍分类接口
  static Future<TravelCategoryModel?> getCategory() async {
    var uri = Uri.parse('https://api.geekailab.com/uapi/ft/category');
    final response = await http.get(uri, headers: hiHeaders());
    // 处理中文乱码
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyStr = utf8decoder.convert(response.bodyBytes);
    debugPrint(bodyStr);

    if (response.statusCode == 200) {
      var result = json.decode(bodyStr);
      return TravelCategoryModel.fromJson(result['data']);
    } else {
      // if (response.statusCode == 401) {
      //    NavigatorUtil.goToLogin();
      //   return null;
      // }
      throw Exception(bodyStr);
    }
  }

  /// 获取旅拍分类下的数据
  static Future<TravelTabModel?> getTravels(String groupChanneCode, int pageIndex, int pageSize) async {
    Map<String, String> paramsMap = {};
    paramsMap['pageIndex'] = pageIndex.toString();
    paramsMap['pageSize'] = pageSize.toString();
    paramsMap['groupChannelCode'] = groupChanneCode;

    var uri = Uri.https('api.geekailab.com', '/uapi/ft/travels', paramsMap);
    final response = await http.get(uri, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyStr = utf8decoder.convert(response.bodyBytes);
    debugPrint(bodyStr);
    if (response.statusCode == 200) {
      var result = json.decode(bodyStr);
      return TravelTabModel.fromJson(result);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(bodyStr);
    }

  }

}