import 'package:freezed_annotation/freezed_annotation.dart';

part 'tale_metadata.freezed.dart';
part 'tale_metadata.g.dart';

@freezed
class TaleMetadata with _$TaleMetadata {
  const TaleMetadata._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaleMetadata({
    @Default('') String coverImageUrl,
    @Default('') String backgroundAudioUrl,
  }) = _TaleMetadata;

  factory TaleMetadata.fromJson(Map<String, dynamic> json) =>
      _$TaleMetadataFromJson(json);

  static const TaleMetadata empty = TaleMetadata();

  bool get hasBackgroundAudio => backgroundAudioUrl.isNotEmpty;
  bool get hasCoverImage => coverImageUrl.isNotEmpty;
}
