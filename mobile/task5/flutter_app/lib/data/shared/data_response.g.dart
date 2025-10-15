// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponse<TModel> _$DataResponseFromJson<TModel>(
  Map<String, dynamic> json,
  TModel Function(Object? json) fromJsonTModel,
) => DataResponse<TModel>(
  isSuccess: json['isSuccess'] as bool?,
  error: json['error'] as String?,
  message: json['message'] as String?,
  data: _$nullableGenericFromJson(json['data'], fromJsonTModel),
)..code = json['code'];

Map<String, dynamic> _$DataResponseToJson<TModel>(
  DataResponse<TModel> instance,
  Object? Function(TModel value) toJsonTModel,
) => <String, dynamic>{
  'isSuccess': ?instance.isSuccess,
  'error': ?instance.error,
  'message': ?instance.message,
  'data': ?_$nullableGenericToJson(instance.data, toJsonTModel),
  'code': ?instance.code,
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);
