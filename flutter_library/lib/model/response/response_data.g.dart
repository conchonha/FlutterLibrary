// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseData<T> _$ResponseDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseData<T>(
      json['message'] as String,
      json['statuscode'] as int,
      json['total'] as int,
      (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ResponseDataToJson<T>(
  ResponseData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'statuscode': instance.statuscode,
      'total': instance.total,
      'data': instance.data.map(toJsonT).toList(),
    };
