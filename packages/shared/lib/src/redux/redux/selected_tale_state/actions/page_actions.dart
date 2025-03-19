import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/redux/redux/action.dart';
import 'package:shared/src/redux/redux/state.dart';
import 'package:uuid/v4.dart';

class SelectPageAction extends DefaultAction {
  final String id;

  SelectPageAction(this.id);

  @override
  AppState? reduce() {
    if (id == selectedTaleState.selectedPageId) {
      return null;
    }

    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        selectedPageId: id,
      ),
    );
  }
}

class AddPageAction extends DefaultAction {
  @override
  AppState reduce() {
    final tale = selectedTaleState.tale;
    final newPageNumber = selectedTaleState.pages.length + 1;

    final newPage = TalePage.newPage(
      id: const UuidV4().generate(),
      taleId: tale.id,
      pageNumber: newPageNumber,
      text: '',
    );

    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        selectedPageId: newPage.id,
        pages: [
          ...selectedTaleState.pages,
          newPage,
        ],
      ),
    );
  }
}

class UpdatePageAction extends DefaultAction {
  final String? text;
  final PlatformFile? backgroundImageFile;
  final String? backgroundImageUrl;
  final int? pageNumber;

  UpdatePageAction({
    this.text,
    this.backgroundImageFile,
    this.backgroundImageUrl,
    this.pageNumber,
  });

  @override
  Future<AppState?> reduce() async {
    if (backgroundImageFile != null) {
      dispatch(_UpdatePageBackgroundImageAction(backgroundImageFile!));
      return null;
    }

    final page = selectedTaleState.selectedPage;
    if (page == null) {
      return null;
    }

    final tale = selectedTaleState.tale;

    if (page.id.isEmpty || tale.id.isEmpty) {
      return null;
    }

    final pageNumber = page.pageNumber;
    TalePage? pageNumberUpdatedPage;

    if (this.pageNumber != null) {
      final pageWithThisNumber = selectedTaleState.pages
          .firstWhereOrNull((e) => e.pageNumber == this.pageNumber);
      if (pageWithThisNumber != null) {
        //replace it with current page pageNumber
        pageNumberUpdatedPage = pageWithThisNumber.copyWith(
          pageNumber: pageNumber,
        );
      }
    }

    //steps:
    //1. update selected page
    final newPage = page.copyWith(
      text: text ?? page.text,
      pageNumber: this.pageNumber ?? page.pageNumber,
      metadata: page.metadata.copyWith(
        backgroundImageUrl:
            backgroundImageUrl ?? page.metadata.backgroundImageUrl,
      ),
    );
    //2. update tale pages
    final newTalePages = selectedTaleState.pages.map((e) {
      if (pageNumberUpdatedPage != null) {
        if (pageNumberUpdatedPage.id == e.id) {
          return pageNumberUpdatedPage;
        }
      }
      if (e.id == page.id) {
        return newPage;
      }
      return e;
    });

    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        pages: newTalePages.toList(),
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

    final page = selectedTaleState.selectedPage;

    if (page == null) {
      return null;
    }

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path: 'page/background/${page.id}.${file.extension!.toLowerCase()}',
    );

    return uploadedResult.when(
      ok: (url) {
        dispatch(UpdatePageAction(backgroundImageUrl: url));
        return null;
      },
      error: (error) {
        return state.copyWith(
          selectedTaleState: selectedTaleState.copyWith(
            taleResult: StateResult.error(error),
          ),
        );
      },
    );
  }
}

class DeletePageAction extends DefaultAction {
  DeletePageAction();

  @override
  Future<AppState?> reduce() async {
    final selectedPage = selectedTaleState.selectedPage;
    if (selectedPage == null) {
      return null;
    }

    if (selectedPage.isNew) {
      //delete from tale and deselect
      final newPages =
          selectedTaleState.pages.where((e) => e.id != selectedPage.id);

      return state.copyWith(
        selectedTaleState: selectedTaleState.copyWith(
          selectedPageId: '',
          pages: newPages.toList(),
        ),
      );
    }

    final deleteResult = await taleRepository.deleteTalePage(selectedPage.id);

    return deleteResult.when(
      ok: (_) {
        final newPages = selectedTaleState.pages
            .where((e) => e.id != selectedPage.id)
            .toList();

        return state.copyWith(
          selectedTaleState: selectedTaleState.copyWith(
            selectedPageId: '',
            pages: newPages,
          ),
        );
      },
      error: (error) {
        return state.copyWith(
          selectedTaleState: selectedTaleState.copyWith(
            taleResult: StateResult.error(error),
          ),
        );
      },
    );
  }
}
