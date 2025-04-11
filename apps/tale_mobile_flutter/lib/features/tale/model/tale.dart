import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tale_mobile_flutter/features/tale/model/localization.dart';
import 'package:tale_mobile_flutter/features/tale/model/page.dart';

part 'tale.freezed.dart';

@freezed
abstract class TaleModel with _$TaleModel {
  const TaleModel._();

  const factory TaleModel({
    required String id,
    @Default('') String title,
    @Default('') String description,
    @Default('landscape') String orientation,
    @Default('') String coverImageUrl,
    @Default('') String backgroundAudioUrl,
    required TaleLocalizationModel localization,
    @Default([]) List<TalePageModel> pages,
  }) = _TaleModel;

  factory TaleModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'];

    var model = TaleModel(
      id: id,
      localization: TaleLocalizationModel(taleId: id),
    );

    if (json['title'] != null) {
      model = model.copyWith(title: json['title']);
    }
    if (json['description'] != null) {
      model = model.copyWith(description: json['description']);
    }
    if (json['orientation'] != null) {
      model = model.copyWith(orientation: json['orientation']);
    }
    if (json['metadata'] != null) {
      final cover = json['metadata']?['cover_image_url'];
      final audio = json['metadata']?['background_audio_url'];
      model = model.copyWith(
        coverImageUrl: cover ?? "",
        backgroundAudioUrl: audio ?? "",
      );
    }
    if (json['localization'] != null) {
      model = model.copyWith(
        localization: TaleLocalizationModel.fromJson(json['localization']),
      );
    }
    if (json['pages'] != null) {
      model = model.copyWith(
        pages:
            (json['pages'] as List)
                .map((e) => TalePageModel.fromJson(e))
                .toList(),
      );
    }
    return model;
  }

  bool get isPortrait => orientation == 'portrait';
  bool get hasCoverImage => coverImageUrl.isNotEmpty;
}
