import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

part 'state.freezed.dart';

@freezed
class TaleEditorState with _$TaleEditorState {
  const TaleEditorState._();
  const factory TaleEditorState({
    required TalePage selectedPage,
  }) = _TaleEditorState;

  factory TaleEditorState.initial() {
    return const TaleEditorState(
      selectedPage: TalePage.empty,
    );
  }

  bool get isPageSelected => selectedPage.id.isNotEmpty;
}
