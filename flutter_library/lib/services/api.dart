import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class DIO {
  late Dio dio;

  DIO() {
    dio = Dio(
      BaseOptions(
          connectTimeout: _defaultConnectTimeout,
          receiveTimeout: _defaultReceiveTimeout,
          responseType: ResponseType.json,
          contentType: ContentType.json.toString(),
          headers: {'Content-Type': 'application/json; charset=UTF-8'}),
    )
      ..interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
      ))
      ..interceptors.add(Interceptor())
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['content-Type'] = 'application/json';
          // options.headers['Authorization'] =
          // 'Bearer ';
          return handler.next(options); //continue
        },
        onError: (DioError error, handler) async {
          debugPrint("error:$error");
          final connectivityResult = await (Connectivity().checkConnectivity());

          if (connectivityResult == ConnectivityResult.none) {
            String errorMessage =
                "Kết nối Internet thất bại. Vui lòng kiểm tra lại kết nối Internet của thiết bị";
            return handler.next(DioError(
                requestOptions: error.requestOptions,
                response: error.response,
                error: errorMessage));
          }

          if (error.response?.statusCode == 401) {
            // navigator into about screen login
          }

          if (error.response?.data != null &&
              error.response?.data is Map<dynamic, dynamic>) {
            final Map<dynamic, dynamic> dataError = error.response?.data;

            try {
              final Map<String, dynamic> dataErrors = dataError['errors'];

              final String errorMessage = dataErrors.keys
                  .map((key) => dataErrors[key].join('\n').trim())
                  .join('\n')
                  .trim();

              return handler.next(DioError(
                  requestOptions: error.requestOptions,
                  response: error.response,
                  error: errorMessage));
            } catch (_) {}

            if (dataError.containsKey('message')) {
              final String errorMessage = dataError['message'];
              return handler.next(DioError(
                  requestOptions: error.requestOptions,
                  response: error.response,
                  error: errorMessage));
            }
          }

          return handler.next(DioError(
              requestOptions: error.requestOptions,
              response: error.response,
              error: "Kết nối Server thất bại. Vui lòng thử lại")); //continue
        },
      ));
  }
}

typedef TypeServices<T> = T Function(Dio dio,{String baseUrl});
class Api<T>{
  late final T client;

  /// when using library register [Api] with [LocatorLibrary] -> singleTon client
  Api(TypeServices<T> getClient) {
    client = getClient as T;
  }

  /// used in special cases such as having many services and many other base urls
  /// -> not register [LocatorLibrary] singleTon
  static V getClientService<V>(TypeServices<V> getClient){
    return getClient as V;
  }
}
