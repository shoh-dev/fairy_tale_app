import 'package:freezed_annotation/freezed_annotation.dart';

// class MyResponseConverter implements JsonConverter<TaleInteraction, Map<String, dynamic>> {
//   const MyResponseConverter();

//   @override
//   TaleInteraction fromJson(Map<String, dynamic> json) {
//     // type data was already set (e.g. because we serialized it ourselves)
//     if (json['runtimeType'] != null) {
//       return TaleInteraction.fromJson(json);
//     }
//     print(json);
//     // you need to find some condition to know which type it is. e.g. check the presence of some field in the json
//     throw Exception('Could not determine the constructor for mapping from JSON');
//   }

//   @override
//   Map<String, dynamic> toJson(TaleInteraction data) => data.toJson();
// }

const appJsonSerializable = JsonSerializable(
  fieldRename: FieldRename.snake,
  // converters: [
  //   MyResponseConverter(),
  // ],
);
