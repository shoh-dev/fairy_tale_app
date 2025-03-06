import 'package:freezed_annotation/freezed_annotation.dart';

part 'tale_page_metadata.freezed.dart';
part 'tale_page_metadata.g.dart';

@freezed
class TalePageMetadata with _$TalePageMetadata {
  const TalePageMetadata._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TalePageMetadata({
    @Default('') String backgroundImageUrl,
    @Default('') String backgroundAudioUrl,
  }) = _TalePageMetadata;

  factory TalePageMetadata.fromJson(Map<String, dynamic> json) =>
      _$TalePageMetadataFromJson(json);

  bool get hasBackgroundAudio => backgroundAudioUrl.isNotEmpty;
  bool get hasBackgroundImage => backgroundImageUrl.isNotEmpty;
}
