import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
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
    required String selectedPageId,
    required String selectedInteractionId,
  }) = _SelectedTaleState;

  factory SelectedTaleState.initial() {
    return SelectedTaleState(
      taleResult: const StateResult.initial(),
      tale: Tale.newTale(UUID.v4()),
      interactions: [],
      pages: [],
      selectedInteractionId: '',
      selectedPageId: '',
    );
  }

  bool get isTaleNew => tale.isNew;
  bool get isPageSelected => selectedPageId.isNotEmpty;
  bool get isInteractionSelected => selectedInteractionId.isNotEmpty;

  TalePage? get selectedPage =>
      pages.firstWhereOrNull((e) => e.id == selectedPageId);
  TaleInteraction? get selectedInteraction =>
      interactions.firstWhereOrNull((e) => e.id == selectedInteractionId);

  List<TaleInteraction> get interactionsForPage =>
      interactions.where((e) => e.talePageId == selectedPageId).toList();
}

bool isTaleNew(AppState state) => state.selectedTaleState.isTaleNew;
bool isPageSelected(AppState state) => state.selectedTaleState.isPageSelected;
bool isInteractionSelected(AppState state) =>
    state.selectedTaleState.isInteractionSelected;
Tale selectedTale(AppState state) => state.selectedTaleState.tale;
TalePage? selectedPage(AppState state) => state.selectedTaleState.selectedPage;
TaleInteraction? selectedInteraction(AppState state) =>
    state.selectedTaleState.selectedInteraction;
List<TaleInteraction> interactionsForPage(AppState state) =>
    state.selectedTaleState.interactionsForPage;
