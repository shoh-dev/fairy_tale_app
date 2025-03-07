import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/list_action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/tale_action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class SelectPageAction extends DefaultAction {
  final TalePage? page;

  SelectPageAction({this.page});

  @override
  AppState? reduce() {
    if (page == editorState.selectedPage) {
      return null;
    }

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedPage: page ?? TalePage.empty(id: '', taleId: ''),
            isTalePageEdited: false, //todo:
          ),
        ),
      ),
    );
  }
}

class AddPageAction extends DefaultAction {
  @override
  AppState reduce() {
    final newPageNumber = taleState.selectedTale.pages.length + 1;

    final newPage = TalePage.newPage(
      id: UUID.v4(),
      taleId: taleState.selectedTale.id,
      text: 'Page $newPageNumber',
      pageNumber: newPageNumber,
    );

    final tale = taleState.selectedTale;

    final newTale = tale.copyWith(
      pages: [...tale.pages, newPage],
    );

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: newTale,
          editorState: editorState.copyWith(
            selectedPage: newPage, //once created select it
          ),
        ),
      ),
    );
  }
}

class UpdatePageAction extends DefaultAction {
  final bool reRender;

  final String? text;
  final PlatformFile? backgroundImageFile;
  final String? backgroundImageUrl;

  UpdatePageAction({
    /// when passed as true, re renders all StoreConnectors using selectedTale
    this.reRender = false,
    this.text,
    this.backgroundImageFile,
    this.backgroundImageUrl,
  });

  @override
  Future<AppState?> reduce() async {
    if (backgroundImageFile != null) {
      dispatch(_UpdatePageBackgroundImageActionV2(backgroundImageFile!));
      return null;
    }

    final page = editorState.selectedPage;
    final tale = taleState.selectedTale;

    //steps:
    //1. update selected page
    final newPage = page.copyWith(
      text: text ?? page.text,
      metadata: page.metadata.copyWith(
        backgroundImageUrl:
            backgroundImageUrl ?? page.metadata.backgroundImageUrl,
      ),
    );
    //2. update tale pages
    final newTalePages = tale.pages.map((e) {
      if (e.id == page.id) {
        return newPage;
      }
      return e;
    });
    final newTale = tale.copyWith(pages: newTalePages.toList());

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: newTale.copyWith(
            toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
          ),
          editorState: editorState.copyWith(
            selectedPage: newPage.copyWith(
              toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
            ),
            isTalePageEdited: false, //todo:
          ),
          isTaleEdited: false, //todo:
        ),
      ),
    );
  }
}

class _UpdatePageBackgroundImageActionV2 extends DefaultAction {
  final PlatformFile file;

  _UpdatePageBackgroundImageActionV2(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final page = taleState.editorState.selectedPage;

    final uploadedResult = await taleRepository.uploadImage(
      bytes: await file.xFile.readAsBytes(),
      path:
          'page_images/background/${page.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(UpdatePageAction(backgroundImageUrl: url, reRender: true));
      },
      error: (error) {
        dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
      },
    );
    return null;
  }
}

class UpdateTaleTranslationsAction extends DefaultAction {
  final String locale;
  final Iterable<String> keys;
  final Iterable<String> values;

  UpdateTaleTranslationsAction({
    required this.locale,
    required this.keys,
    required this.values,
  });

  @override
  Future<AppState?> reduce() async {
    final selectedTale = taleState.selectedTale;
    // final oldTranslations = Map.of(selectedTale.localizations.translations);
    final newTranslations = Map.of(selectedTale.localizations.translations);

    newTranslations[locale] = Map<String, String>.fromIterables(keys, values);

    //todo: check why this is not working
    // if (mapEquals(oldTranslations, newTranslations)) {
    //   return null;
    // }

    dispatch(UpdateTaleAction(translations: newTranslations));
    return null;
  }
}

/// TEST DONE UP TO HERE

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
            selectedInteraction:
                interaction ?? TaleInteraction.empty(id: '', talePageId: ''),
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

    final selectedPage = editorState.selectedPage;
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
            selectedPage: newPage,
          ),
        ),
      ),
    );
  }
}

class SaveInteractionsAction extends DefaultAction {
  @override
  AppState? reduce() {
    final selectedPage = editorState.selectedPage;
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
    final selectedPage = editorState.selectedPage;
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
            selectedPage: newPage,
            isInteractionEdited: true,
          ),
        ),
      ),
    );
  }
}

class SaveTaleAction extends DefaultAction {
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

    Log().debug('tale $taleResult');
    Log().debug('pages $pagesResult');
    Log().debug('locale $localizationResult');
    // Log().debug('interactions $interactionsResult');

    dispatchAll([
      GetTaleListAction(),
      GetTaleAction(taleId: selectedTale.id),
    ]);

    return null;
  }
}
