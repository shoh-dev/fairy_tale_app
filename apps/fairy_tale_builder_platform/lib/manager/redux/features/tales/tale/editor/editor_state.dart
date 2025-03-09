import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'editor_state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();

  const factory TaleEditorState({
    required StateResult interactionResult,
    required String selectedPageId,
    required String selectedInteractionId,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return const TaleEditorState(
      selectedPageId: '',
      selectedInteractionId: '',
      interactionResult: StateResult.initial(),
    );
  }
}
