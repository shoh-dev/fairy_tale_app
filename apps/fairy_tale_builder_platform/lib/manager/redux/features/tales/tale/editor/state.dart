import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();

  const factory TaleEditorState({
    required TalePage selectedTalePage,
    required TaleInteraction selectedInteraction,
    required bool isTalePageEdited,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return const TaleEditorState(
      selectedTalePage: TalePage.empty,
      selectedInteraction: TaleInteraction.empty,
      isTalePageEdited: false,
    );
  }

  bool isPageSelected(TalePage page) => selectedTalePage == page;
  bool isInteractionSelected(TaleInteraction interaction) =>
      selectedInteraction == interaction;
}
