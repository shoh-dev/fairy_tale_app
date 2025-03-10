import 'dart:async';
import 'dart:developer';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/list_action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/interaction_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/page_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class ResetTaleStateAction extends DefaultAction {
  @override
  AppState? reduce() {
    dispatchAll([
      ResetInteractinAction(),
      ResetPageAction(),
      GetTaleAction(),
    ]);

    return null;
  }
}

// class DisposeTaleAction extends DefaultAction {
//   @override
//   AppState? reduce() {
//     taleState.tale.disposeAudioPlayers();
//     return null;
//   }
// }

class TaleAction extends DefaultAction {
  final StateResult? selectedTaleResult;
  final Tale? tale;

  TaleAction({
    this.tale,
    this.selectedTaleResult,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          tale: tale ?? taleState.tale,
          taleResult: selectedTaleResult ?? taleState.taleResult,
        ),
      ),
    );
  }
}

class GetTaleAction extends DefaultAction {
  final String taleId;

  GetTaleAction({
    /// if taleId is empty, selects an empty tale
    this.taleId = '',
  });

  @override
  Future<AppState?> reduce() async {
    dispatch(TaleAction(selectedTaleResult: const StateResult.loading()));

    if (taleId.isEmpty) {
      dispatch(
        TaleAction(
          selectedTaleResult: const StateResult.ok(),
          tale: Tale.newTale(UUID.v4()),
        ),
      );
      return null;
    }

    final tale = await taleRepository.getTaleById(taleId);

    await tale.when(
      ok: (tale) async {
        dispatch(
          TaleAction(
            tale: tale.copyWith(pages: tale.pages),
            selectedTaleResult: const StateResult.ok(),
          ),
        );
      },
      error: (error) {
        dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
      },
    );
    return null;
  }
}

class UpdateTaleAction extends DefaultAction {
  final bool reRender;

  final String? title;
  final String? description;
  final String? orientation;
  final PlatformFile? coverImageFile;
  final String? coverImageUrl;
  final Map<String, Map<String, String>>? translations;
  final List<TalePage>? pages;
  final PlatformFile? backgroundAudioFile;
  final String? backgroundAudioUrl;

  UpdateTaleAction({
    /// when passed as true, re renders all StoreConnectors using selectedTale
    this.reRender = false,
    this.title,
    this.description,
    this.orientation,
    this.coverImageFile,
    this.coverImageUrl,
    this.translations,
    this.pages,
    this.backgroundAudioFile,
    this.backgroundAudioUrl,
  });

  @override
  AppState? reduce() {
    final tale = taleState.tale;

    if (tale.id.isEmpty) {
      return null;
    }

    if (coverImageFile != null) {
      dispatch(_UpdateTaleCoverImageAction(coverImageFile!));
      return null;
    }

    if (backgroundAudioFile != null) {
      dispatch(_UpdateTaleBackgroundAudioAction(backgroundAudioFile!));
      return null;
    }

    final newTale = tale.copyWith(
      title: title ?? tale.title,
      description: description ?? tale.description,
      orientation: orientation ?? tale.orientation,
      localizations: tale.localizations.copyWith(
        translations: translations ?? tale.localizations.translations,
      ),
      metadata: tale.metadata.copyWith(
        coverImageUrl: coverImageUrl ?? tale.metadata.coverImageUrl,
        backgroundAudioUrl:
            backgroundAudioUrl ?? tale.metadata.backgroundAudioUrl,
      ),
      pages: pages ?? tale.pages,
    );

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          tale: newTale.copyWith(
            toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
          ),
        ),
      ),
    );
  }
}

class _UpdateTaleCoverImageAction extends DefaultAction {
  final PlatformFile file;

  _UpdateTaleCoverImageAction(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final tale = taleState.tale;

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path: 'tale/covers/${tale.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(UpdateTaleAction(coverImageUrl: url, reRender: true));
      },
      error: (error) {
        dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
      },
    );
    return null;
  }
}

class _UpdateTaleBackgroundAudioAction extends DefaultAction {
  final PlatformFile file;

  _UpdateTaleBackgroundAudioAction(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final tale = taleState.tale;

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path:
          'tale/background_audios/${tale.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(UpdateTaleAction(backgroundAudioUrl: url));
      },
      error: (error) {
        dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
      },
    );
    return null;
  }
}

class DeleteTaleAction extends DefaultAction {
  DeleteTaleAction();

  @override
  Future<AppState?> reduce() async {
    final tale = taleState.tale;

    if (tale.isNew) {
      //todo: handle on UI part

      dispatch(
        ResetTaleStateAction(),
      );

      return null;
    }

    final deleteResult = await taleRepository.deleteTale(tale.id);

    deleteResult.when(
      ok: (_) {
        dispatchAll([
          ResetTaleStateAction(),
          GetTaleListAction(),
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
    final selectedTale = taleState.tale;

    if (taleState.isTaleValidToSave.isNotEmpty) {
      log('SaveTaleAction: ${taleState.isTaleValidToSave} not valid');
      return null;
    }

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

    Logger('tale').info(taleResult);
    Logger('pages').info(pagesResult);
    Logger('locale').info(localizationResult);
    Logger('interactions').info(interactionsResult);

    dispatchAll([
      ResetPageAction(),
      GetTaleAction(taleId: selectedTale.id),
      GetTaleListAction(),
    ]);

    return null;
  }
}
