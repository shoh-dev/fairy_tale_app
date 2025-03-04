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
    required String backgroundImage,
    @Default('') String backgroundAudio,
    @Default([]) List<TaleInteraction> taleInteractions,
  }) = _TalePage;

  static const empty = TalePage(
    id: '',
    taleId: '',
    pageNumber: 0,
    text: '',
    backgroundImage: '',
  );

  factory TalePage.fromJson(Map<String, dynamic> json) =>
      _$TalePageFromJson(json);

  bool get hasBackgroundAudio => backgroundAudio.isNotEmpty;

  //updateInteractionMethod
  TalePage updateInteraction(TaleInteraction interaction) {
    final interactions = List<TaleInteraction>.from(taleInteractions);
    final index =
        interactions.indexWhere((element) => element.id == interaction.id);
    if (index != -1) {
      interactions[index] = interaction;
    }
    return copyWith(taleInteractions: interactions);
  }
}
