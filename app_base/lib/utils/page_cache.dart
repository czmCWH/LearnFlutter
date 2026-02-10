import 'package:flutter/material.dart';

class PageCacheManager {
  static final PageCacheManager _instance = PageCacheManager._internal();
  factory PageCacheManager() => _instance;
  PageCacheManager._internal();

  final Map<String, Widget> _cachedPages = {};

  void cachePage(String key, Widget page) {
    _cachedPages[key] = page;
  }

  Widget? getCachedPage(String key) {
    return _cachedPages[key];
  }

  void removeCachedPage(String key) {
    _cachedPages.remove(key);
  }

  void clearAllCache() {
    _cachedPages.clear();
  }

  bool isPageCached(String key) {
    return _cachedPages.containsKey(key);
  }

  // 新增：获取或创建页面
  Widget getOrCreatePage(String key, Widget Function() builder) {
    if (!isPageCached(key)) {
      cachePage(key, builder());
    }
    return getCachedPage(key)!;
  }
}