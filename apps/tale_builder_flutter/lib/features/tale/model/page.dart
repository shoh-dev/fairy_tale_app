import 'package:freezed_annotation/freezed_annotation.dart';

part 'page.freezed.dart';

@freezed
abstract class TalePageModel with _$TalePageModel {
  const TalePageModel._();

  const factory TalePageModel({
    required String id,
    required String taleId,

    ///for now not using this property
    @Default(-1) int pageNumber,
    @Default('') String text,
    @Default(false) bool isNew,
    // @Default(TalePageModelMetadata.empty) TalePageModelMetadata metadata,
  }) = _TalePageModel;

  factory TalePageModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final taleId = json['tale_id'] as String;
    var model = TalePageModel.empty(id: id, taleId: taleId);

    if (json['page_number'] != null) {
      model = model.copyWith(pageNumber: json['page_number'] as int);
    }
    if (json['text'] != null) {
      model = model.copyWith(text: json['text'] as String);
    }
    if (json['metadata'] != null) {
      model = model.copyWith(
        // metadata: TalePageModelMetadata.fromJson(
        // json['metadata'] as Map<String, dynamic>,
        // ),
      );
    }

    return model;
  }

  factory TalePageModel.empty({required String id, required String taleId}) =>
      TalePageModel(id: id, taleId: taleId);

  factory TalePageModel.newPage({
    required String id,
    required String taleId,
    required String text,
    required int pageNumber,
  }) => TalePageModel.empty(
    id: id,
    taleId: taleId,
  ).copyWith(text: text, pageNumber: pageNumber, isNew: true);
}
