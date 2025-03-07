import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'editor_state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();

  const factory TaleEditorState({
    required TalePage selectedTalePage,
    required TaleInteraction selectedInteraction,
    required bool isTalePageEdited,
    required bool isInteractionEdited,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return TaleEditorState(
      selectedTalePage: TalePage.empty(),
      selectedInteraction: TaleInteraction.empty(),
      isTalePageEdited: false,
      isInteractionEdited: false,
    );
  }

  bool isPageSelected(TalePage page) => selectedTalePage == page;
  bool isInteractionSelected(TaleInteraction interaction) =>
      selectedInteraction == interaction;
}
