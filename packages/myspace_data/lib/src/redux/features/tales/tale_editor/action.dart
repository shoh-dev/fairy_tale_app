import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data/src/models.dart';
import 'package:myspace_data/src/redux/action.dart';
import 'package:myspace_data/src/redux/state.dart';

class SelectEditorTalePageAction extends DefaultAction {
  final TalePage? page;

  /// if [page] is null, it will unselect the page
  SelectEditorTalePageAction(this.page);

  @override
  AppState reduce() {
    return state.copyWith(
      taleEditorState: state.taleEditorState.copyWith(
        selectedPage: page ?? TalePage.empty,
      ),
    );
  }
}

class UpdateSelectedTalePageAction extends DefaultAction {
  final TalePage page;

  UpdateSelectedTalePageAction(this.page);

  @override
  AppState? reduce() {
    if (page == taleEditorState.selectedPage) {
      return null;
    }

    final index = state.taleState.selectedTale.talePages.indexWhere((e) => e.id == page.id);

    if (index == -1) {
      return null;
    }

    final updatedTale = state.taleState.selectedTale.copyWith(
      talePages: List.from(state.taleState.selectedTale.talePages)..[index] = page,
    );

    return state.copyWith(
      taleState: state.taleState.copyWith(selectedTale: updatedTale),
      taleEditorState: taleEditorState.copyWith(selectedPage: page),
    );
  }
}

class SelectEditorTalePageInteractionAction extends DefaultAction {
  final List<TaleInteraction> interaction;

  /// if [interaction] is null, it will unselect the page
  SelectEditorTalePageInteractionAction(this.interaction);

  @override
  AppState reduce() {
    return state.copyWith(
      taleEditorState: state.taleEditorState.copyWith(
        selectedInteractions: List.of(interaction),
      ),
    );
  }
}

class UpdateSelectedInteractionAction extends DefaultAction {
  final TaleInteraction interaction;

  /// if [interaction] is null, it will unselect the page
  UpdateSelectedInteractionAction(this.interaction);

  @override
  AppState? reduce() {
    final selectedInteractions = List.of(state.taleEditorState.selectedInteractions);

    final index = selectedInteractions.indexWhere((e) => e.id == interaction.id);

    if (index == -1) {
      return null;
    }

    selectedInteractions[index] = interaction;

    final selectedPage = state.taleEditorState.selectedPage;

    final pageInteractionIndex = selectedPage.taleInteractions.indexWhere((e) => e.id == interaction.id);

    if (pageInteractionIndex == -1) {
      return null;
    }

    final updatedPage = selectedPage.copyWith(
      taleInteractions: List.from(selectedPage.taleInteractions)..[pageInteractionIndex] = interaction,
    );

    final selectedTale = state.taleState.selectedTale;

    final taleIndex = selectedTale.talePages.indexWhere((e) => e.id == selectedPage.id);

    if (taleIndex == -1) {
      return null;
    }

    final updatedTale = selectedTale.copyWith(
      talePages: List.from(selectedTale.talePages)..[taleIndex] = updatedPage,
    );

    return state.copyWith(
      taleState: state.taleState.copyWith(
        selectedTale: updatedTale,
      ),
      taleEditorState: state.taleEditorState.copyWith(
        selectedPage: updatedPage,
        selectedInteractions: List.from(selectedInteractions),
      ),
    );
  }
}

class AddEmptyTalePageAction extends DefaultAction {
  @override
  AppState reduce() {
    final tale = state.taleState.selectedTale.copyWith(
      talePages: List.from(state.taleState.selectedTale.talePages)..add(TalePage.empty.copyWith(id: "${state.taleState.selectedTale.talePages.length + 1}")),
    );

    return state.copyWith(
      taleState: state.taleState.copyWith(
        selectedTale: tale,
      ),
    );
  }
}

class AddEmptyTalePageInteractionAction extends DefaultAction {
  @override
  AppState? reduce() {
    final selectedPage = state.taleEditorState.selectedPage.copyWith(
      taleInteractions: List.from(state.taleEditorState.selectedPage.taleInteractions)
        ..add(TaleInteraction.empty.copyWith(id: "${state.taleEditorState.selectedPage.taleInteractions.length + 1}")),
    );

    final selectedTale = state.taleState.selectedTale;

    final index = selectedTale.talePages.indexWhere((e) => e.id == selectedPage.id);

    if (index == -1) {
      return null;
    }

    final updatedTale = selectedTale.copyWith(
      talePages: List.from(selectedTale.talePages)..[index] = selectedPage,
    );

    return state.copyWith(
      taleState: state.taleState.copyWith(
        selectedTale: updatedTale,
      ),
      taleEditorState: state.taleEditorState.copyWith(
        selectedPage: selectedPage,
      ),
    );
  }
}
