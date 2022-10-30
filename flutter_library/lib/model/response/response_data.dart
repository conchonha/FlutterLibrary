import 'package:json_annotation/json_annotation.dart';

///
/// {'message' : 'Success','statuscode' : 200, 'total' : 5,'data' : [{'name':'SangTB','age':23}]}
/// Using retrofit apply response with format above
/// User(name,age) :object using JsonSerializable auto generate builder
/// + fromJson
/// + toJson
/// terminal using retrofit and room
///  flutter pub run build_runner build --delete-conflicting-outputs
///
part 'response_data.g.dart';

@JsonSerializable(explicitToJson: true,genericArgumentFactories: true)
class ResponseData<T>{
  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'statuscode')
  int statuscode;

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'data')
  List<T> data;

  ResponseData(this.message, this.statuscode, this.total, this.data);

  factory ResponseData.fromJson(Map<String, dynamic> json,T Function(Object? json) fromJsonT) =>
      _$ResponseDataFromJson<T>(json,fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) => _$ResponseDataToJson<T>(this,toJsonT);
}