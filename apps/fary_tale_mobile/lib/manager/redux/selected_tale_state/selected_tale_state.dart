import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

part 'selected_tale_state.freezed.dart';

@freezed
class SelectedTaleState with _$SelectedTaleState {
  const SelectedTaleState._();

  const factory SelectedTaleState({
    required StateResult taleResult,
    required Tale tale,
    required List<TalePage> pages,
    required List<TaleInteraction> interactions,
  }) = _SelectedTaleState;

  factory SelectedTaleState.initial() {
    return SelectedTaleState(
      taleResult: const StateResult.initial(),
      tale: Tale.empty(''),
      interactions: [],
      pages: [],
    );
  }

  List<TaleInteraction> interactionsForPage(String pageId) =>
      interactions.where((e) => e.talePageId == pageId).toList();
}
