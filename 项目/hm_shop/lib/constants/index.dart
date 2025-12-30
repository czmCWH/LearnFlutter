/// 定义全局的常量
class GlobalConstants {
  /// 基础地址
  static const String BASE_URL = "https://meikou-api.itheima.net"; 
  /// 超时时间
  static const int TIME_OUT = 10; 
  /// 成功状态
  static const String SUCCESS_CODE = "1"; 
  /// token对应持久化的key
  static const String TOKEN_KEY = "shop_token"; 
}

/// 定义请求地址接口的常量
class HttpConstants {
  /// 首页轮播列表
  static const String BANNER_LIST = "/home/banner";
  /// 分类列表
  static const String CATEGORY_LIST = "/home/category/head"; 
  /// 特惠推荐地址
  static const String PRODUCT_LIST = "/hot/preference";
  /// 热榜推荐地址 
  static const String IN_VOGUE_LIST = "/hot/inVogue"; 
  /// 一站式推荐地址
  static const String ONE_STOP_LIST = "/hot/oneStop"; 
  /// 推荐列表
  static const String RECOMMEND_LIST = "/home/recommend";
  
  /// 猜你喜欢接口地址 
  static const String GUESS_LIST = "/home/goods/guessLike"; 

  /// 登录请求地址
  static const String LOGIN = "/login"; 
  /// 用户信息接口地址
  static const String USER_PROFILE = '/member/profile'; 
  // 返回的结构体 是GoodsItems类型
}