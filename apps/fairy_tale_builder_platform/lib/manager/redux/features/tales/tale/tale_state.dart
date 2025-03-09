import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/editor_state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

part 'tale_state.freezed.dart';

@freezed
class TaleState with _$TaleState {
  const TaleState._();
  const factory TaleState({
    required StateResult selectedTaleResult,
    required Tale selectedTale,
    required bool isTaleEdited,
    required TaleEditorState editorState,
  }) = _TaleState;

  factory TaleState.initial() {
    return TaleState(
      selectedTaleResult: const StateResult.loading(),
      selectedTale: Tale.newTale(UUID.v4()),
      isTaleEdited: false,
      editorState: TaleEditorState.initial(),
    );
  }
}
