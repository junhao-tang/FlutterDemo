import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:developer';

import 'package:dio/dio.dart';

enum HttpMethod { get, post }

class Request {
  final String path;
  final HttpMethod method;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? queryParams;

  Request(
    this.method,
    this.path, {
    this.queryParams,
    this.data,
  });
}

// Set up a mock HTTP client.
class HttpClient {
  late Dio _client;

  HttpClient(String baseUrl) {
    _client = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 3000,
        receiveTimeout: 3000,
        headers: {
          "contentType": "application/json",
        },
      ),
    )..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        developer.log(
            "${options.path} ${options.queryParameters.toString().toUpperCase()} ${options.data}");
        return handler.next(options);
      }, onResponse: (response, handler) {
        developer.log(
            "${response.requestOptions.path} ${response.statusCode} ${response.data}");
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: `handler.reject(dioError)`
      }, onError: (DioError e, handler) {
        developer.log("${e.requestOptions.path} ${e.response} ${e.message}");
        return handler.next(e);
      }));
  }

  bool get isMock => _client.options.baseUrl == "";

  Future<dynamic> handle(
      Request r, Future<String> Function(Request r) mockApi) async {
    if (isMock) {
      return jsonDecode(await mockApi(r));
    }
    try {
      final response = await _client.request(
        r.path,
        options: Options(method: r.method.name),
        data: r.data == null ? null : jsonEncode(r.data),
        queryParameters: r.queryParams,
      );
      return response.data;
    } on DioError catch (e, stacktrace) {
      log("router $stacktrace, ${e.message}, ${e.response}");
      if (e.response == null) {
        throw ConnectionException();
      }
      var data = e.response!.data;
      if (data is Map && data["msg"] != null) {
        throw ServerException(data["msg"]);
      }
      throw ConnectionException();
    }
  }
}

class ConnectionException implements Exception {
  ConnectionException();

  @override
  String toString() => "http";
}

class ServerException implements Exception {
  ServerException(this.reason);
  String reason;

  @override
  String toString() => reason;
}
