import 'package:freezed_annotation/freezed_annotation.dart';

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
    return TaleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      orientation: json['orientation'],
      backgroundAudioUrl: '', //todo:
      coverImageUrl: json['metadata']?['cover_image_url'] ?? "", //todo:
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    json['description'] = description;
    json['orientation'] = orientation;
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

  bool get isPortrait => orientation == 'portrait';

  bool get hasCoverImage => coverImageUrl.isNotEmpty;
}
