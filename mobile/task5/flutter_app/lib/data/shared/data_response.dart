import 'package:json_annotation/json_annotation.dart';

part 'data_response.g.dart';
@JsonSerializable(genericArgumentFactories: true,includeIfNull: false,explicitToJson: true)
class DataResponse<TModel>{
  bool? isSuccess;
  String? error;
  String? message;
  TModel? data;

  dynamic code;
  DataResponse({this.isSuccess, this.error, this.message, this.data});

  factory DataResponse.fromJson(Map<String, dynamic> json, TModel Function(Object? json) fromJsonT,) => _$DataResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(TModel value) toJsonT) => _$DataResponseToJson(this, toJsonT);
}