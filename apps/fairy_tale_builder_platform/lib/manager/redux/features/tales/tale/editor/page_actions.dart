import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/tale_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class ResetPageAction extends DefaultAction {
  ResetPageAction();

  @override
  AppState? reduce() {
    if (taleState.editorState.selectedPageId.isEmpty) {
      return null;
    }

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedPageId: '',
          ),
        ),
      ),
    );
  }
}

class SelectPageAction extends DefaultAction {
  final String id;

  SelectPageAction(this.id);

  @override
  AppState? reduce() {
    if (id == taleState.editorState.selectedPageId) {
      return null;
    }

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedPageId: id,
          ),
        ),
      ),
    );
  }
}

class AddPageAction extends DefaultAction {
  @override
  AppState reduce() {
    final newPageNumber = taleState.tale.pages.length + 1;

    final newPage = TalePage.newPage(
      id: UUID.v4(),
      taleId: taleState.tale.id,
      pageNumber: newPageNumber,
      text: '',
    );

    final tale = taleState.tale;

    final newTale = tale.copyWith(
      pages: [...tale.pages, newPage],
    );

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          tale: newTale,
          editorState: editorState.copyWith(
            selectedPageId: newPage.id, //once created select it
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

    final page = taleState.selectedPage;
    if (page == null) {
      return null;
    }

    final tale = taleState.tale;

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
          tale: newTale.copyWith(
            toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
          ),
          editorState: editorState.copyWith(
            selectedPageId: newPage.id,
          ),
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

    final page = taleState.selectedPage;

    if (page == null) {
      return null;
    }

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path: 'page/background/${page.id}.${file.extension!.toLowerCase()}',
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
    final selectedPage = taleState.selectedPage;
    if (selectedPage == null) {
      return null;
    }

    if (selectedPage.isNew) {
      //delete from tale and deselect
      final selectedTale = taleState.tale;
      final newPages = selectedTale.pages.where((e) => e.id != selectedPage.id);

      dispatch(
        UpdateTaleAction(pages: newPages.toList()),
      );

      dispatch(ResetPageAction());

      return null;
    }

    final deleteResult = await taleRepository.deleteTalePage(selectedPage.id);

    deleteResult.when(
      ok: (_) {
        final newPages =
            taleState.tale.pages.where((e) => e.id != selectedPage.id).toList();
        dispatchAll([
          ResetPageAction(),
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
