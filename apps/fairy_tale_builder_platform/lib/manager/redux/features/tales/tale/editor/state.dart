import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();

  const factory TaleEditorState({
    required TalePage selectedTalePage,
    required bool isTalePageEdited,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return const TaleEditorState(
      selectedTalePage: TalePage.empty,
      isTalePageEdited: false,
    );
  }

  bool isPageSelected(TalePage page) => selectedTalePage == page;
}
