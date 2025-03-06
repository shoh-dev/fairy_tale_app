import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/repositories/tale/models.dart';

part 'tale_interaction_metadata.freezed.dart';
part 'tale_interaction_metadata.g.dart';

@freezed
class TaleInteractionMetadata with _$TaleInteractionMetadata {
  const TaleInteractionMetadata._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TaleInteractionMetadata({
    @Default(TaleInteractionSize(40, 40)) TaleInteractionSize size,
    @JsonKey(name: 'initial_pos')
    @Default(TaleInteractionPosition.zero)
    TaleInteractionPosition initialPosition,
    @Default('') String imageUrl,
    @Default('') String audioUrl,
    @JsonKey(name: 'final_pos') TaleInteractionPosition? finalPosition,
  }) = _TaleInteractionMetadata;

  factory TaleInteractionMetadata.fromJson(Map<String, dynamic> json) =>
      _$TaleInteractionMetadataFromJson(json);

  bool get hasAudio => audioUrl.isNotEmpty;
  bool get hasImage => imageUrl.isNotEmpty;
}
