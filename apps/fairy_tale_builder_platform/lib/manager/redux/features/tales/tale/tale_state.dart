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
    required StateResult taleResult,
    required Tale tale,
    required TaleEditorState editorState,
  }) = _TaleState;

  factory TaleState.initial() {
    return TaleState(
      taleResult: const StateResult.loading(),
      tale: Tale.newTale(UUID.v4()),
      editorState: TaleEditorState.initial(),
    );
  }

  TalePage? get selectedPage =>
      tale.pages.firstWhereOrNull((e) => e.id == editorState.selectedPageId);

  TaleInteraction? get selectedInteraction => selectedPage?.interactions
      .firstWhereOrNull((e) => e.id == editorState.selectedInteractionId);

  /// if returns empty string means tale is valid to save
  /// otherwise returns error with which field is invalid
  ModelValidation get isTaleValidToSave {
    return tale.isValidToSave..addAll(isInteractionsValidToSave);
  }

  ModelValidation get isInteractionsValidToSave {
    return selectedPage?.isInteractionsValidToSave ?? {};
  }
}
