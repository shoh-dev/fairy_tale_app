import 'package:freezed_annotation/freezed_annotation.dart';

part 'tale_interaction_metadata.freezed.dart';
part 'tale_interaction_metadata.g.dart';

@freezed
class TaleInteractionMetadata with _$TaleInteractionMetadata {
  const TaleInteractionMetadata._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaleInteractionMetadata({
    @Default('') String imageUrl,
    @Default('') String audioUrl,
  }) = _TaleInteractionMetadata;

  factory TaleInteractionMetadata.fromJson(Map<String, dynamic> json) =>
      _$TaleInteractionMetadataFromJson(json);

  bool get hasAudio => audioUrl.isNotEmpty;
  bool get hasImage => imageUrl.isNotEmpty;
}
