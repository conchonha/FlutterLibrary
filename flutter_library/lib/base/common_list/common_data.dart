import 'package:json_annotation/json_annotation.dart';
import 'package:floor/floor.dart';

@JsonSerializable()
class CommonData {
  @JsonKey(ignore: true)
  final DataType? dataType;

  CommonData({
    this.dataType = DataType.TYPE_LIST_ARROW_PREVIEW,
  });
}

enum DataType {
  TYPE_LIST_ARROW,
  TYPE_LIST_ARROW_PREVIEW,
  TYPE_CHECKBOX,
  TYPE_CHECKBOX_PREVIEW,
  TYPE_RADIO,
  TYPE_RADIO_PREVIEW,
  TYPE_OTHER
}

/// Noteworthy: when using room
///Because room only stores primitive values => when save DataType -> Exception
///-> solution using [DataTypeConverter] on @TypeConverters([DataTypeConverter]) of RoomDataBase
class DataTypeConverter extends TypeConverter<DataType?, String?> {
  @override
  DataType? decode(String? databaseValue) {
    switch (databaseValue) {
      case "TYPE_LIST_ARROW_PREVIEW":
        return DataType.TYPE_LIST_ARROW_PREVIEW;
      case "TYPE_LIST_ARROW":
        return DataType.TYPE_LIST_ARROW;
      case "TYPE_OTHER":
        return DataType.TYPE_OTHER;
      case "TYPE_CHECKBOX":
        return DataType.TYPE_CHECKBOX;
      case "TYPE_CHECKBOX_PREVIEW":
        return DataType.TYPE_CHECKBOX_PREVIEW;
      case "TYPE_RADIO_PREVIEW":
        return DataType.TYPE_RADIO_PREVIEW;
      default:
        return DataType.TYPE_RADIO;
    }
  }

  @override
  String? encode(DataType? value) {
    return value?.name;
  }
}
