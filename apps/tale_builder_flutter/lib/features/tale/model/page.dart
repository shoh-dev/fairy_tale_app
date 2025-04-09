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

    @Default('') String backgroundImageUrl,
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
      final image = json['metadata']['background_image_url'];
      model = model.copyWith(
        backgroundImageUrl: image ?? "",
        // metadata: TalePageModelMetadata.fromJson(
        // json['metadata'] as Map<String, dynamic>,
        // ),
      );
    }

    return model;
  }

  //todo: when toJson
  //remove q query from backgroundImageUrl

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

  bool get hasImage => backgroundImageUrl.isNotEmpty;

  String get backgroundImageBucketPath {
    if (hasImage) {
      //http://127.0.0.1:54321/storage/v1/object/public/default/page/background/0aa79713-c11b-4d1c-ac44-4c42218cde91.png
      //todo: if debug mode
      final split = backgroundImageUrl.replaceAll(
        "http://127.0.0.1:54321/storage/v1/object/public/default/",
        "",
      );
      return split;
    }
    return '';
  }
}
