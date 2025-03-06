import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class SelectEditorTalePageAction extends DefaultAction {
  final TalePage? page;

  SelectEditorTalePageAction(this.page);

  @override
  AppState? reduce() {
    if (page == editorState.selectedTalePage) {
      return null;
    }
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedTalePage: page ?? TalePage.empty(),
            isTalePageEdited: page != null,
          ),
        ),
      ),
    );
  }
}

class AddNewTalePageAction extends DefaultAction {
  @override
  AppState reduce() {
    final newPage = TalePage.newPage(
      id: UUID.v4(),
      text: (taleState.selectedTale.pages.length + 1).toString(),
      pageNumber: taleState.selectedTale.pages.length + 1,
      taleId: taleState.selectedTale.id,
    );
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: taleState.selectedTale.copyWith(
            pages: [...taleState.selectedTale.pages, newPage],
          ),
          editorState: editorState.copyWith(
            selectedTalePage: newPage,
          ),
        ),
      ),
    );
  }
}

class SetIsTalePageEditedAction extends DefaultAction {
  final TalePage? newPage;

  SetIsTalePageEditedAction({
    required this.newPage,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            isTalePageEdited: newPage != editorState.selectedTalePage,
          ),
        ),
      ),
    );
  }
}

class UpdateSelectedTalePageAction extends DefaultAction {
  final TalePage page;

  UpdateSelectedTalePageAction(this.page);

  @override
  AppState reduce() {
    final newTalePages = taleState.selectedTale.pages.map((e) {
      if (e.id == page.id) {
        return page;
      }
      return e;
    }).toList();

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: taleState.selectedTale.copyWith(
            pages: newTalePages,
          ),
          editorState: editorState.copyWith(
            selectedTalePage: page,
            isTalePageEdited: false,
          ),
        ),
      ),
    );
  }
}

class SaveSelectedTaleLocalizationAction extends DefaultAction {
  final String locale;
  final Iterable<String> keys;
  final Iterable<String> values;

  SaveSelectedTaleLocalizationAction({
    required this.locale,
    required this.keys,
    required this.values,
  });

  @override
  Future<AppState?> reduce() async {
    final selectedTale = taleState.selectedTale;

    final oldTranslation =
        selectedTale.localizations.translations[locale] ?? <String, String>{};
    final newTranslation = Map<String, String>.fromIterables(keys, values);

    if (mapEquals(oldTranslation, newTranslation)) {
      return null;
    }

    var newLocalizations = selectedTale.localizations;

    final newMap = Map.of(newLocalizations.translations);

    newMap[locale] = newTranslation;

    newLocalizations = newLocalizations.copyWith(
      translations: newMap,
    );

    // // //todo: handle result
    // // final result =
    // await taleRepository.saveTaleLocalization(
    //   taleId: newLocalizations.taleId,
    //   translations: newLocalizations.translations,
    //   defaultLocale: newLocalizations.defaultLocale,
    // );

    return state.copyWith(
      applicationState: applicationState.copyWith(
        localizationState: applicationState.localizationState.copyWith(
          locale: locale,
        ),
      ),
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: selectedTale.copyWith(
            localizations: newLocalizations,
          ),
        ),
      ),
    );
  }
}

class SelectInteractionAction extends DefaultAction {
  final TaleInteraction? interaction;

  SelectInteractionAction(this.interaction);

  @override
  AppState? reduce() {
    if (editorState.selectedInteraction == interaction) {
      return null;
    }

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedInteraction: interaction ?? TaleInteraction.empty(),
          ),
        ),
      ),
    );
  }
}

class UpdateSelectedInteractionAction extends DefaultAction {
  final TaleInteraction interaction;

  UpdateSelectedInteractionAction(this.interaction);

  @override
  AppState? reduce() {
    if (editorState.selectedInteraction == interaction) {
      return null;
    }

    final selectedPage = editorState.selectedTalePage;
    final interactions = selectedPage.interactions.map((e) {
      if (e.id == interaction.id) {
        return interaction;
      }
      return e;
    });

    final newPage = selectedPage.copyWith(interactions: interactions.toList());

    final oldPages = taleListState.taleState.selectedTale.pages;
    final oldPage = oldPages.firstWhere((element) => element.id == newPage.id);

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            isInteractionEdited:
                !listEquals(oldPage.interactions, newPage.interactions),
            selectedInteraction: interaction,
            selectedTalePage: newPage,
          ),
        ),
      ),
    );
  }
}

class SaveInteractionsAction extends DefaultAction {
  @override
  AppState? reduce() {
    final selectedPage = editorState.selectedTalePage;
    //replace page with selectedPage from list of selectedTale pages
    final newPages = taleListState.taleState.selectedTale.pages.map((e) {
      if (e.id == selectedPage.id) {
        return selectedPage;
      }
      return e;
    });

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            isInteractionEdited: false,
          ),
          selectedTale: taleState.selectedTale.copyWith(
            pages: newPages.toList(),
          ),
        ),
      ),
    );
  }
}

class AddEmptyInteractionAction extends DefaultAction {
  @override
  AppState? reduce() {
    final selectedPage = editorState.selectedTalePage;
    final newPage = selectedPage.copyWith(
      interactions: [
        ...selectedPage.interactions,
        TaleInteraction.newInteraction(
          id: UUID.v4(),
          talePageId: selectedPage.id,
        ),
      ],
    );
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedTalePage: newPage,
            isInteractionEdited: true,
          ),
        ),
      ),
    );
  }
}

class SaveSelectedTaleAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    final selectedTale = taleState.selectedTale;

    dispatch(TaleAction(selectedTaleResult: const StateResult.loading()));

    //todo: handle result
    final taleResult = await taleRepository.saveTale(selectedTale);
    final localizationResult = await taleRepository.saveTaleLocalization(
      defaultLocale: selectedTale.localizations.defaultLocale,
      translations: selectedTale.localizations.translations,
      taleId: selectedTale.id,
    );
    final pagesResult = await taleRepository.saveTalePages(selectedTale.pages);
    final interactionsResult = await taleRepository.saveTaleInteractions(
      selectedTale.pages.expand((e) => e.interactions).toList(),
    );

    dispatch(GetTaleAction(taleId: selectedTale.id));

    return null;
  }
}
