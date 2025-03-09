import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'tale_page_metadata.freezed.dart';

@freezed
class TalePageMetadata with _$TalePageMetadata {
  const TalePageMetadata._();

  const factory TalePageMetadata({
    @Default('') String backgroundImageUrl,
    @Default('') String backgroundAudioUrl,
  }) = _TalePageMetadata;

  factory TalePageMetadata.fromJson(Map<String, dynamic> json) {
    try {
      var model = empty;

      if (json['background_image_url'] != null) {
        model = model.copyWith(
          backgroundImageUrl: json['background_image_url'] as String,
        );
      }
      if (json['background_audio_url'] != null) {
        model = model.copyWith(
          backgroundAudioUrl: json['background_audio_url'] as String,
        );
      }

      return model;
    } catch (e, st) {
      Log().error('TalePageMetadata.fromJson', e, st);
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    final json = {
      'background_image_url': backgroundImageUrl,
      'background_audio_url': backgroundAudioUrl,
    }..removeWhere((key, value) => value.isEmpty);

    return json;
  }

  static const empty = TalePageMetadata();

  bool get hasBackgroundAudio => backgroundAudioUrl.isNotEmpty;
  bool get hasBackgroundImage => backgroundImageUrl.isNotEmpty;
}
