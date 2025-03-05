import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

part 'state.freezed.dart';

@freezed
class TaleState with _$TaleState {
  const TaleState._();
  const factory TaleState({
    required StateResult selectedTaleResult,
    required Tale selectedTale,
    required TaleEditorState editorState,
    required bool isTaleEdited,
  }) = _TaleState;

  factory TaleState.initial() {
    return TaleState(
      selectedTale: Tale.empty,
      selectedTaleResult: const StateResult.loading(),
      editorState: TaleEditorState.initial(),
      isTaleEdited: false,
    );
  }
}
