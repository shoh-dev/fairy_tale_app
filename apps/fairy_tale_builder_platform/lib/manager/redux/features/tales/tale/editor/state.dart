import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();

  const factory TaleEditorState({
    required TalePage selectedTalePage,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return const TaleEditorState(
      selectedTalePage: TalePage.empty,
    );
  }

  bool get isPageSelected => selectedTalePage.id.isNotEmpty;
}
