import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'tale_metadata.freezed.dart';

@freezed
class TaleMetadata with _$TaleMetadata {
  const TaleMetadata._();

  const factory TaleMetadata({
    @Default('') String coverImageUrl,
    @Default('') String backgroundAudioUrl,
  }) = _TaleMetadata;

  factory TaleMetadata.fromJson(Map<String, dynamic> json) {
    try {
      var model = empty;

      if (json['cover_image_url'] != null) {
        model = model.copyWith(
          coverImageUrl: json['cover_image_url'] as String,
        );
      }
      if (json['background_audio_url'] != null) {
        model = model.copyWith(
          backgroundAudioUrl: json['background_audio_url'] as String,
        );
      }

      return model;
    } catch (e, st) {
      Log().error('TaleMetadata.fromJson', e, st);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final json = {
      'cover_image_url': coverImageUrl,
      'background_audio_url': backgroundAudioUrl,
    }..removeWhere((key, value) => value.isEmpty);

    return json;
  }

  static const TaleMetadata empty = TaleMetadata();

  bool get hasBackgroundAudio => backgroundAudioUrl.isNotEmpty;
  bool get hasCoverImage => coverImageUrl.isNotEmpty;
}
