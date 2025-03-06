import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:shared/shared.dart';

List<Tale> taleListSelector(AppState state) => state.taleListState.taleList;
Tale selectedTaleSelector(AppState state) =>
    state.taleListState.taleState.selectedTale;
List<TalePage> talePagesSelector(AppState state) =>
    selectedTaleSelector(state).pages;
TalePage selectedTalePageSelector(AppState state) =>
    state.taleListState.taleState.editorState.selectedTalePage;
TaleInteraction selectedInteractionSelector(AppState state) =>
    state.taleListState.taleState.editorState.selectedInteraction;
bool isTalePageSelectedSelector(AppState state, TalePage page) =>
    state.taleListState.taleState.editorState.isPageSelected(page);
bool isTaleEditedSelector(AppState state) =>
    state.taleListState.taleState.isTaleEdited;
bool isTalePageEditedSelector(AppState state) =>
    state.taleListState.taleState.editorState.isTalePageEdited;
