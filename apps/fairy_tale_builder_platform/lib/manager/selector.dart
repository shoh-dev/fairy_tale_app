import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:shared/shared.dart';

List<Tale> taleListSelector(AppState state) => state.taleListState.list;
Tale selectedTaleSelector(AppState state) => state.taleListState.taleState.tale;
List<TalePage> talePagesSelector(AppState state) =>
    selectedTaleSelector(state).pages;
TalePage? selectedTalePageSelector(AppState state) =>
    state.taleListState.taleState.selectedPage;
TaleInteraction selectedInteractionSelector(AppState state) =>
    state.taleListState.taleState.editorState.selectedInteraction;
bool isTalePageSelectedSelector(AppState state, TalePage page) =>
    state.taleListState.taleState.selectedPage == page;
