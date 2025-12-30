/*
  封装一个 API 目的：返回业务层需要的数据结构
 */

import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

/// 获取首页轮播图 List 
Future<List<BannerItem>> getBannerListAPI() async {
  final res = await dioRequest.get(HttpConstants.BANNER_LIST);
  
  return (res as List).map((item) {
    return BannerItem.formJSON(item);
  }).toList();
}

// 获取首页分类列表
Future<List<CategoryItem>> getCategoryListAPI() async {
  // 返回请求
  return ((await dioRequest.get(HttpConstants.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

// 特惠推荐
Future<SpecialRecommendResult> getProductListAPI() async {
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.PRODUCT_LIST),
  );
}

// 热榜推荐
Future<SpecialRecommendResult> getInVogueListAPI() async {
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.IN_VOGUE_LIST),
  );
}

// 一站式推荐
Future<SpecialRecommendResult> getOneStopListAPI() async {
  // 返回请求
  return SpecialRecommendResult.formJSON(
    await dioRequest.get(HttpConstants.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(Map<String, dynamic> params) async {
  final res = await dioRequest.get(HttpConstants.RECOMMEND_LIST, params: params);
  return (res as List).map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
