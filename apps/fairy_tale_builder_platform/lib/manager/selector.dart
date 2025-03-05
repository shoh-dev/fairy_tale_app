import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:shared/shared.dart';

List<Tale> taleListSelector(AppState state) => state.taleListState.taleList;
Tale selectedTaleSelector(AppState state) =>
    state.taleListState.taleState.selectedTale;
List<TalePage> talePagesSelector(AppState state) =>
    selectedTaleSelector(state).talePages;
TalePage selectedTalePageSelector(AppState state) =>
    state.taleListState.taleState.editorState.selectedTalePage;
bool isTalePageSelectedSelector(AppState state) =>
    state.taleListState.taleState.editorState.isPageSelected;
