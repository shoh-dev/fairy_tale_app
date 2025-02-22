import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();
  const factory TaleEditorState({
    required TalePage selectedPage,
    required List<TaleInteraction> selectedInteractions,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return const TaleEditorState(
      selectedPage: TalePage.empty,
      selectedInteractions: [],
    );
  }

  bool get isPageSelected => selectedPage.id.isNotEmpty;
  bool get isInteractionSelected => selectedInteractions.isNotEmpty;
}
