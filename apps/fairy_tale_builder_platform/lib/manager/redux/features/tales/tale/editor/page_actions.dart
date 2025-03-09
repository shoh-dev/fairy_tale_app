import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/list_action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/tale_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
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
      dispatch(_UpdatePageBackgroundImageAction(backgroundImageFile!));
      return null;
    }

    final page = editorState.selectedPage;
    final tale = taleState.selectedTale;

    if (page.id.isEmpty || tale.id.isEmpty) {
      return null;
    }

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

class _UpdatePageBackgroundImageAction extends DefaultAction {
  final PlatformFile file;

  _UpdatePageBackgroundImageAction(this.file);

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

class DeletePageAction extends DefaultAction {
  DeletePageAction();

  @override
  Future<AppState?> reduce() async {
    final selectedPage = taleState.editorState.selectedPage;

    if (selectedPage.isNew) {
      //delete from tale and deselect
      final selectedTale = taleState.selectedTale;
      final newPages = selectedTale.pages.where((e) => e.id != selectedPage.id);

      dispatch(
        UpdateTaleAction(pages: newPages.toList()),
      );

      dispatch(SelectPageAction());

      return null;
    }

    final deleteResult = await taleRepository.deleteTalePage(selectedPage.id);

    deleteResult.when(
      ok: (_) {
        final newPages = taleState.selectedTale.pages
            .where((e) => e.id != selectedPage.id)
            .toList();
        dispatchAll([
          SelectPageAction(),
          UpdateTaleAction(pages: newPages.toList()),
        ]);
      },
      error: (error) {
        dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
      },
    );

    return null;
  }
}

//! TEST DONE UP TO HERE

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
    Log().debug('interactions $interactionsResult');

    dispatchAll([
      GetTaleListAction(),
      GetTaleAction(taleId: selectedTale.id),
    ]);

    return null;
  }
}
