/*
  封装网络请求工具类：
    1、安装 Dio 插件：flutter pub add dio；
    2、定义常量数据：如，基础地址、超时时间、业务状态、请求地址；
    3、封装网络请求工具，基础地址，拦截器；
    4、请求工具进一步解构，处理 http 状态 和 业务状态；
    5、定义数据类型 和 工厂转化函数（即将转化动态类型到对象类型）；
    6、封装请求API调用类工厂函数
    7、初始化数据更新状态
 */

import 'package:dio/dio.dart';
import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/stores/TokenManager.dart';

/// 基于  插件封装网络请求工具
class DioRequest {
  // Dio 请求对象
  final _dio = Dio();

  // 构造器
  DioRequest() {
    // 1、配置 Dio，采用 .. 连续赋值
    _dio.options
      ..baseUrl = GlobalConstants.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);

    // 2、设置拦截器
    _addInterceptor();
  }

  void _addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      // 1、请求拦截器
      onRequest: (options, handler) {
        // 注入 token 
        if (tokenManager.getToken().isNotEmpty) {
          // options.headers = {
          //   "Authorization": "Bearer ${tokenManager.getToken()}",
          // };
          options.headers["Authorization"] = "Bearer ${tokenManager.getToken()}";
        }
        
        // 放行请求
        handler.next(options);
      },
      // 2、响应拦截器
      onResponse: (response, handler) {
        // http 状态码
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          // 请求成功，放行响应结果
          handler.next(response);
          return;
        }
        
        // 请求失败，进入失败响应
        handler.reject(DioException(requestOptions: response.requestOptions));
      },
      onError: (error, handler) {
        // handler.reject(error);
        // 处理 http 请求异常
        handler.reject(
          DioException(
            requestOptions: error.requestOptions, 
            message: error.response?.data["msg"] ?? ''
          )
        );
      },
    ));
  }

  // 定义 get 请求
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    // _handleResponse 处理后返回的数据为真正的数据 
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // 定义 post 请求 
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  /// 解析 Dio 请求的结果数据
  /// 由于 Dio 请求返回的数据为 Response<dynamic>.data，我们需要拿到真正的数据 data，并判断业务逻辑是否正确。
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        // 此时，http 请求状态码 和 业务状态码均正常，放行请求通过
        return data["result"];
      } 

      // 业务状态码错误，抛出错误
      // throw Exception(data["msg"] ?? "数据加载异常");
      throw DioException(requestOptions: res.requestOptions, message: data["msg"] ?? "数据加载异常");
    } catch (e) {
      // throw Exception(e);
      rethrow;  // 不改变原始的 DioException 异常，继续向上抛出
    }
  }

}

// 单例请求对象
final dioRequest = DioRequest();
