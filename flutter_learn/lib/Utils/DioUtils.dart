import 'package:dio/dio.dart';

// Dio 网络请求工具类
class DioUtils {
  
  final Dio _dio = Dio();

  // 1、构造函数进行初始化配置
  DioUtils() {
    // 基础地址
    // _dio.options.baseUrl = "https://geek.itheima.net/v1_0";
    // // 超时时间
    // _dio.options.connectTimeout = const Duration(seconds: 10);  // 连接超时
    // _dio.options.sendTimeout = const Duration(seconds: 10);  // 发送超时
    // _dio.options.receiveTimeout = const Duration(seconds: 10);  // 接收超时

    // Flutter 链式语法
    _dio.options
      ..baseUrl = "https://geek.itheima.net/v1_0/"    // ⚠️，基础地址最后需要跟上 /
      ..connectTimeout = const Duration(seconds: 10)
      ..sendTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10);

    // 注册拦截器
    _addInterceptor();

  }

  void _addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      // 1、请求拦截
      onRequest: (context, handler) {
        // 放行请求
        handler.next(context);

        // 拦截请求
        // handler.reject(error);
      },
      // 2、响应拦截
      onResponse: (context, handler) {
        // 校验http状态码
        if (context.statusCode! >= 200 && context.statusCode! < 300) {
          handler.next(context);  // 放行
          return;
        }

        // 请求失败，抛出异常
        handler.reject(DioException(requestOptions: context.requestOptions));
      },
      // 3、错误拦截
      onError: (context, handler) {
        handler.reject(context);
      }
    ));
  }

  // 向外暴露 get 方法
  Future<Response<dynamic>> get(String url, {Map<String, dynamic>? params}) {
    return _dio.get(url, queryParameters: params);
  }

}