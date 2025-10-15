import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get/get.dart' as getx;
import '../utils/route/routes.dart';
import '../utils/utils.dart';
import 'api_provider/api_provider.dart';

class Injector {
  static final Injector _singleton = Injector._internal();
  static final _dio = Dio();

  factory Injector() {
    return _singleton;
  }
  ApiProvider apiProvider() {
    return ApiProvider();
  }

  Injector._internal();

  Dio getDio() {
    BaseOptions options = BaseOptions(
      receiveTimeout: const Duration(seconds: 320),
      connectTimeout: const Duration(seconds: 120),
    );
    _dio.options = options;
    _dio.options.followRedirects = false;
    _dio.options.headers["Content-Type"] = "application/json";
    (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };
    _dio.interceptors.clear();
    _dio.interceptors.add(LoggingInterceptors());
    // dio.interceptors.add(LogInterceptor(responseBody: false)); //开启请求日志
    return _dio;
  }

  static Future<Options?> getHeaderToken() async {
    // String? token = StorageHelper().getUserToken();
    // if (token != null) {
    //   print("token=$token");
    //   var userId = StorageHelper().getUserId();
    //   if (userId != null) {
    //     print("userId=$userId");
    //   }

    //   var headers = {'Authorization': 'Bearer $token'};

    //   var projectId = StorageHelper().getProjectId();
    //   if (projectId != null) {
    //     headers["projectId"] = projectId;
    //   }

    //   return Options(headers: headers);
    // }
    return null;
  }
}

class LoggingInterceptors extends Interceptor {
  String printObject(Object object) {
    // Encode your object and then decode your object to Map variable
    Map jsonMapped = json.decode(json.encode(object));

    // Using JsonEncoder for spacing
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');

    // encode it to string
    String prettyPrint = encoder.convert(jsonMapped);
    return prettyPrint;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
      "--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}",
    );
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    print("queryParameters:");
    options.queryParameters.forEach((k, v) => print('$k: $v'));
    if (options.data != null) {
      try {
        // print("Body: ${printObject(options.data)}");
        FormData formData = options.data as FormData;
        print("Body:");
        var buffer = [];
        for (MapEntry<String, String> pair in formData.fields) {
          buffer.add('${pair.key}:${pair.value}');
        }
        print("Body:{${buffer.join(', ')}}");
      } catch (e) {
        print("Body: ${printObject(options.data)}");
      }
    }
    print(
      "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}",
    );
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException dioError, ErrorInterceptorHandler handler) {
    print(
      "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.response!.requestOptions.path) : 'URL')}",
    );
    print(
      "${dioError.response != null ? dioError.response!.data : 'Unknown Error'}",
    );
    print("<-- End error");
    if (dioError.response?.data["code"] == 403) {
      // StorageHelper().clearAll();
      // Utils.hideLoader();
      // SocketHelper().disconnect();
      getx.Get.offAllNamed(Routes.restaurantsScreen);
      // MyApp.startFirstScreen(dioError.response?.data["message"]);
      return;
    }

    return super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}",
    );
    print("Headers:");
    response.headers.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    log("<-- END HTTP");

    return super.onResponse(response, handler);
  }
}

class StorageHelper {}
