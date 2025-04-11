import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tale_mobile_flutter/features/tale/model/text.dart';

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
    @Default('') String backgroundImageUrl,
    @Default([]) List<TalePageTextModel> texts,
  }) = _TalePageModel;

  factory TalePageModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final taleId = json['tale_id'] as String;
    var model = TalePageModel(id: id, taleId: taleId);

    if (json['page_number'] != null) {
      model = model.copyWith(pageNumber: json['page_number'] as int);
    }
    if (json['text'] != null) {
      model = model.copyWith(text: json['text'] as String);
    }
    if (json['metadata'] != null) {
      final image = json['metadata']['background_image_url'];
      model = model.copyWith(backgroundImageUrl: image ?? "");
    }
    if (json['texts'] != null) {
      final texts = (json['texts'] as List).map(
        (text) => TalePageTextModel.fromJson(text),
      );
      model = model.copyWith(texts: texts.toList());
    }

    return model;
  }

  bool get hasBackgroundImage => backgroundImageUrl.isNotEmpty;
}
