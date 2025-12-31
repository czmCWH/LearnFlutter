import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/rendering.dart';

/*
  封装网络请求工具类：
    1、安装 Dio 插件：flutter pub add dio；
    2、定义常量数据：如，基础地址、超时时间、业务状态、请求地址；
    3、封装网络请求工具，基础地址，拦截器；
    4、请求工具进一步解构，处理 http 状态 和 业务状态；
    5、定义数据类型 和 工厂转化函数（即将转化动态类型到对象类型）；
    6、封装请求API调用类工厂函数
    7、初始化数据更新状态

  测试接口：
    https://api.devio.org/uapi/test/test?requestPrams=12
    
 */

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
      ..baseUrl = "https://api.devio.org/uapi/ft"    // ⚠️，基础地址最后需要跟上 /
      ..connectTimeout = const Duration(seconds: 10)
      ..sendTimeout = const Duration(seconds: 10)
      ..receiveTimeout = const Duration(seconds: 10);

    // 注册拦截器
    _addInterceptor();

  }

  void _addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      // 1、请求拦截
      onRequest: (options, handler) {
        // 注入 token 
        // if (tokenManager.getToken().isNotEmpty) {
        //   // options.headers = {
        //   //   "Authorization": "Bearer ${tokenManager.getToken()}",
        //   // };
        //   options.headers["Authorization"] = "Bearer ${tokenManager.getToken()}";
        // }
         options.headers["Authorization"] = "Bearer 12312313123113";
        // 放行请求
        handler.next(options);

        // 拦截请求
        // handler.reject(error);
      },
      // 2、响应拦截
      onResponse: (response, handler) {
        // 校验http状态码
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          handler.next(response);  // 放行
          return;
        }

        // 请求失败，抛出业务异常
        handler.reject(DioException(requestOptions: response.requestOptions));
      },
      // 3、错误拦截
      onError: (exception, handler) {
        var errorMsg = "";
        // 1. 获取 HTTP 状态码（例如 404, 500, 401 等）
        final statusCode = exception.response?.statusCode;
        if (statusCode == 401) {
          errorMsg = "Token不正确, 请登录";
        } else if (statusCode == 404) {
          errorMsg = "资源未找到";
        } else if (statusCode == 500) {
          errorMsg = "服务器内部错误";
        }

        // 2. 获取 Dio 错误类型（用于区分网络问题 vs 业务错误）
        log('Dio Error Type: ${exception.type}');
        if (exception.type == DioExceptionType.connectionTimeout) {
          errorMsg = "连接超时";
        } else if (exception.type == DioExceptionType.receiveTimeout) {
          errorMsg = "接收超时";
        } else if (exception.type == DioExceptionType.badCertificate) {
          errorMsg = "SSL 证书错误";
        } else if (exception.type == DioExceptionType.cancel) {
          errorMsg = "请求被取消";
        } else {
          errorMsg = "未知网络错误";
        }

        // 2. 获取原始响应体（如果有）
        final responseBody = exception.response?.data;
        log('Response Body: $responseBody');
        if (![null, ''].contains(responseBody["msg"])) {
          errorMsg = responseBody["msg"];
        } 

        log("[http Code:$statusCode], [response Code:${responseBody["code"]}], msg = $errorMsg");

        // 处理 http 请求异常
        handler.reject(
          DioException(
            response: exception.response,
            requestOptions: exception.requestOptions, 
            message: errorMsg
          )
        );
      }
    ));

    // 添加 Curl 打印 拦截器
    _dio.interceptors.add(CurlInterceptor());
  }

  // 定义 get 请求
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    // _handleResponse 处理后返回的数据为真正的数据 
    Options options = Options(
                        headers: {
                          'course-flag': 'ft', 
                        }
                      );
    return _handleResponse(_dio.get(url, queryParameters: params, options: options));
  }

  // 定义 post 请求 
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    // 可手动配置 header 中 content-type 的数据：
    Options options = Options(
                        contentType: Headers.jsonContentType,
                        // 或者额外配置
                        // headers: {
                        //   'Content-Type': 'application/json', 
                        // }
                      );
    return _handleResponse(_dio.post(url, data: data, options: options));
  }

  /// 解析 Dio 请求的结果数据
  /// 由于 Dio 请求返回的数据为 Response<dynamic>.data，我们需要拿到真正的数据 data，并判断业务逻辑是否正确。
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == 1) {
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
final dioTool = DioUtils();

/// 实现一个拦截器，用于在每次发送请求前打印出等效的 curl 命令，便于调试或与后端联调
class CurlInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _printCurlCommand(options);
    super.onRequest(options, handler);
  }

  void _printCurlCommand(RequestOptions options) {
    final StringBuffer curl = StringBuffer('curl');

    // 添加 URL
    curl.write(" -X ${options.method.toUpperCase()} '${options.uri}'");

    // 添加 headers（包括 Content-Type）
    for (final entry in options.headers.entries) {
      final key = entry.key;
      final value = entry.value;
      if (value != null) {
        curl.write(" -H '$key: $value'");
      }
    }

    // 处理 body
    final data = options.data;

    if (data != null) {
      String bodyString;

      // 判断是否为 FormData（用于文件上传）
      if (data is FormData) {
        // 对于 FormData，通常用 -F 参数，但 curl 打印复杂，这里简化为显示字段
        // 更完整的实现可遍历 fields 和 files
        final fields = <String>[];
        for (final field in data.fields) {
          fields.add("-F '${field.key}=${field.value}'");
        }
        for (final file in data.files) {
          // 注意：实际文件路径不可知，只能显示字段名和文件名
          fields.add("-F '${file.key}=<FILE:${file.value.filename}>'");
        }
        if (fields.isNotEmpty) {
          curl.write(' ${fields.join(' ')}');
        }
      } else {
        // 普通数据：JSON、Map、String 等
        if (data is Map || data is List) {
          bodyString = jsonEncode(data);
        } else if (data is String) {
          bodyString = data;
        } else {
          bodyString = data.toString();
        }

        // 转义双引号和反斜杠，以便在 shell 中安全使用
        bodyString = bodyString.replaceAll(r'\', r'\\').replaceAll('"', r'\"');

        curl.write(" -d \"$bodyString\"");
      }
    }

    log('\n========== CURL COMMAND ==========');
    log(curl.toString());
    log('==================================\n');
  }
}



void log(String? msg, {int? wrapWidth}) {
  if (kDebugMode) {
    debugPrint(msg, wrapWidth: wrapWidth);
  }
}