import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'editor_state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();

  const factory TaleEditorState({
    required TalePage selectedPage,
    required TaleInteraction selectedInteraction,
    required bool isTalePageEdited,
    required bool isInteractionEdited,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return TaleEditorState(
      selectedPage: TalePage.empty(id: '', taleId: ''),
      selectedInteraction:
          TaleInteraction.empty(id: '', talePageId: ''), //todo: handle
      isTalePageEdited: false,
      isInteractionEdited: false,
    );
  }

  bool isPageSelected(TalePage page) => selectedPage == page;
  bool isInteractionSelected(TaleInteraction interaction) =>
      selectedInteraction == interaction;
}
