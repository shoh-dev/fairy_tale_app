// TalePage Model
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/src/repositories/tale/models.dart';

part 'tale_page.freezed.dart';
part 'tale_page.g.dart';

@freezed
class TalePage with _$TalePage {
  const TalePage._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TalePage({
    required String id,
    required String taleId,
    required int pageNumber,
    required String text,
    required TalePageMetadata metadata,
    @Default([]) List<TaleInteraction> interactions,
    @Default(false) bool isNew,
  }) = _TalePage;

  static const empty = TalePage(
    id: '',
    taleId: '',
    pageNumber: 0,
    text: '',
    metadata: TalePageMetadata(),
  );

  static const newPage = TalePage(
    id: '',
    taleId: '',
    pageNumber: 0,
    text: '',
    metadata: TalePageMetadata(),
    isNew: true,
  );

  factory TalePage.fromJson(Map<String, dynamic> json) =>
      _$TalePageFromJson(json);

  bool get hasBackgroundAudio => metadata.hasBackgroundAudio;

  //updateInteractionMethod
  TalePage updateInteraction(TaleInteraction interaction) {
    final interactions = List<TaleInteraction>.from(this.interactions);
    final index =
        interactions.indexWhere((element) => element.id == interaction.id);
    if (index != -1) {
      interactions[index] = interaction;
    }
    return copyWith(interactions: interactions);
  }
}
