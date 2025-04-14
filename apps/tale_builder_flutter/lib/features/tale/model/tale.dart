import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tale_builder_flutter/features/tale/model/localization.dart';

part 'tale.freezed.dart';

@freezed
abstract class TaleModel with _$TaleModel {
  const TaleModel._();

  const factory TaleModel({
    required String id,
    required String title,
    required String description,
    required String orientation,
    required String coverImageUrl,
    required String backgroundAudioUrl,
    @Default(false) bool isNew,
  }) = _TaleModel;

  factory TaleModel.fromJson(Map<String, dynamic> json) {
    final meta = json['metadata'];
    return TaleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      orientation: json['orientation'],
      backgroundAudioUrl: '', //todo:
      coverImageUrl: meta['cover_image_url'],
    );
  }

  Map<String, dynamic> toJson(TaleLocalizationModel localization) {
    final json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['description'] = description;
    json['orientation'] = orientation;
    json['default_locale_title'] = localization.defaultTranslations[title];
    json['metadata'] = {
      "cover_image_url": coverImageUrl,
      "background_audio_url": backgroundAudioUrl,
    };
    return json;
  }

  factory TaleModel.newTale(String id) => TaleModel(
    id: id,
    title: '',
    description: '',
    orientation: 'landscape',
    coverImageUrl: '',
    backgroundAudioUrl: '',
    isNew: true,
  );

  String get coverImageBucketPath {
    if (hasCoverImage) {
      //todo: if debug mode
      final split = coverImageUrl.replaceAll(
        "http://127.0.0.1:54321/storage/v1/object/public/default/",
        "",
      );
      //todo: replace q=datetime if exists
      return split;
    }
    return '';
  }

  bool get isPortrait => orientation == 'portrait';

  bool get hasCoverImage => coverImageUrl.isNotEmpty;
}
