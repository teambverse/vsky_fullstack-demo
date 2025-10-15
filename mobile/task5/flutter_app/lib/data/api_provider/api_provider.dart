import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../injector.dart';
import '../network_handling.dart';
import '../shared/data_response.dart';
import '../shared/page_response.dart';

class ApiProvider {
  late Dio _dio;
  ApiProvider() {
    _dio = Injector().getDio();
  }
  Future<R> request<T, R>({
    required String endpoint,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParams,
    required T Function(Map<String, dynamic>) fromJson,
    required R Function(dynamic) parseResponse,
  }) async {
    try {
      Options? options = await Injector.getHeaderToken();
      late Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await _dio.get(
            endpoint,
            queryParameters: queryParams,
            options: options,
          );
          break;
        case 'POST':
          response = await _dio.post(endpoint, data: data, options: options);
          break;
        case 'PUT':
          response = await _dio.put(endpoint, data: data, options: options);
          break;
        case 'DELETE':
          response = await _dio.delete(endpoint, data: data, options: options);
          break;
        default:
          throw UnsupportedError('Method $method not supported');
      }

      return parseResponse(response.data);
    } on DioException catch (dioError) {
      // Extract message from server if present
      String message = NetworkHandling.getDioException(dioError);

      if (dioError.response?.data is Map &&
          dioError.response?.data['message'] != null) {
        message = dioError.response?.data['message'];
      }

      if (R == DataResponse<T>) {
        return DataResponse<T>(message: message, isSuccess: false) as R;
      } else if (R == PageResponse<T>) {
        return PageResponse<T>(
          message: message,
          isSuccess: false,
          data: [],
          total: 0,
        ) as R;
      } else {
        return parseResponse({'isSuccess': false, 'message': message});
      }
    } catch (e) {
      if (R == DataResponse<T>) {
        return DataResponse<T>(
          message: NetworkHandling.getDioException(e),
          isSuccess: false,
        ) as R;
      } else if (R == PageResponse<T>) {
        return PageResponse<T>(
          message: NetworkHandling.getDioException(e),
          isSuccess: false,
          data: [],
          total: 0,
        ) as R;
      } else {
        rethrow;
      }
    }
  }

  // Future<DataResponse<UploadModel?>> uploadImage(String imagePath) async {
  //   try {
  //     File file = File(imagePath);
  //     String fileType = imagePath.substring(imagePath.lastIndexOf(".") + 1);
  //     String fileName = file.path.split('/').last;

  //     FormData formData = FormData.fromMap({
  //       "file": await MultipartFile.fromFile(
  //         file.path,
  //         filename: fileName,
  //         contentType: MediaType(Utils.getFileType(imagePath)!, fileType),
  //       ),
  //     });

  //     Response response = await _dio.post(
  //       ApiConstant.fileUploads,
  //       options: await Injector.getHeaderToken(),
  //       data: formData,
  //     );
  //     var dataResponse = DataResponse<UploadModel>.fromJson(
  //       response.data,
  //       (data) => UploadModel.fromJson(data as Map<String, dynamic>),
  //     );
  //     return dataResponse;
  //   } catch (e) {
  //     return DataResponse(message: e.toString(), isSuccess: false);
  //   }
  // }
}
