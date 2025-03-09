import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'editor_state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();

  const factory TaleEditorState({
    required String selectedPageId,
    required TaleInteraction selectedInteraction,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return TaleEditorState(
      selectedPageId: '',
      selectedInteraction: TaleInteraction.empty(id: '', talePageId: ''),
    );
  }

  // bool isPageSelected(TalePage page) => selectedPage.id == page.id;
  // bool isInteractionSelected(TaleInteraction interaction) =>
  // selectedInteraction.id == interaction.id;

  // bool get isInteractionsValidToSave {
  //   if (selectedPage.interactions.isEmpty) {
  //     return true;
  //   }
  //   return selectedPage.interactions
  //       .every((interaction) => interaction.isValidToSave);
  // }
}
