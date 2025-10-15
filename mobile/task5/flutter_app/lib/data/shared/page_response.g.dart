// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse<TModel> _$PageResponseFromJson<TModel>(
  Map<String, dynamic> json,
  TModel Function(Object? json) fromJsonTModel,
) => PageResponse<TModel>(
  totalRecords: (json['totalRecords'] as num?)?.toInt(),
  pageNo: (json['pageNo'] as num?)?.toInt(),
  pageSize: (json['pageSize'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  isSuccess: json['isSuccess'] as bool?,
  error: json['error'] as String?,
  message: json['message'] as String?,
  items: (json['items'] as List<dynamic>?)?.map(fromJsonTModel).toList(),
  data: (json['data'] as List<dynamic>?)?.map(fromJsonTModel).toList(),
);

Map<String, dynamic> _$PageResponseToJson<TModel>(
  PageResponse<TModel> instance,
  Object? Function(TModel value) toJsonTModel,
) => <String, dynamic>{
  'totalRecords': ?instance.totalRecords,
  'pageNo': ?instance.pageNo,
  'pageSize': ?instance.pageSize,
  'total': ?instance.total,
  'isSuccess': ?instance.isSuccess,
  'error': ?instance.error,
  'message': ?instance.message,
  'items': ?instance.items?.map(toJsonTModel).toList(),
  'data': ?instance.data?.map(toJsonTModel).toList(),
};
