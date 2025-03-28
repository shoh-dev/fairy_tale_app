import 'dart:async';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/redux/redux/action.dart';
import 'package:uuid/v4.dart';

class ResetTaleAction extends DefaultAction {
  @override
  AppState? reduce() {
    return state.copyWith(
      selectedTaleState: SelectedTaleState.initial(),
    );
  }
}

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
      selectedTaleState: selectedTaleState.copyWith(
        tale: tale ?? selectedTaleState.tale,
        taleResult: selectedTaleResult ?? selectedTaleState.taleResult,
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
    if (taleId.isEmpty) {
      dispatch(
        TaleAction(
          selectedTaleResult: const StateResult.ok(),
          tale: Tale.newTale(const UuidV4().generate()),
        ),
      );
      return null;
    }

    dispatch(TaleAction(selectedTaleResult: const StateResult.loading()));

    final tale = await taleRepository.getTaleById(taleId);

    return tale.when(
      ok: (result) {
        return state.copyWith(
          selectedTaleState: selectedTaleState.copyWith(
            tale: result.$1,
            pages: result.$2,
            interactions: result.$3,
            selectedPageId: result.$2.firstOrNull?.id ?? '',
            taleResult: const StateResult.ok(),
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

class UpdateTaleAction extends DefaultAction {
  final bool reRender;

  final String? title;
  final String? description;
  final String? orientation;
  final PlatformFile? coverImageFile;
  final String? coverImageUrl;
  final Map<String, Map<String, String>>? translations;
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
    this.backgroundAudioFile,
    this.backgroundAudioUrl,
  });

  @override
  AppState? reduce() {
    final tale = selectedTaleState.tale;

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
    );

    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        tale: newTale.copyWith(
          toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
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

    final tale = selectedTaleState.tale;

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

    final tale = selectedTaleState.tale;

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
    final tale = selectedTaleState.tale;

    if (tale.isNew) {
      dispatch(ResetTaleAction());
      return null;
    }

    final deleteResult = await taleRepository.deleteTale(tale.id);

    deleteResult.when(
      ok: (_) {
        dispatchAll([
          // ResetTaleStateAction(),
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
    final tale = selectedTaleState.tale;

    final newTranslations = Map.of(tale.localizations.translations);
    newTranslations[locale] = Map<String, String>.fromIterables(keys, values);

    dispatch(UpdateTaleAction(translations: newTranslations));
    return null;
  }
}

class SaveTaleAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    final tale = selectedTaleState.tale;

    //validate tale
    final isTaleValid = tale.isValidToSave;
    if (isTaleValid.isNotEmpty) {
      log(isTaleValid.toString());
      throwException(ErrorX(isTaleValid));
      return null;
    } else {
      await Future.wait([
        taleRepository.saveTale(tale),
        taleRepository.saveTaleLocalization(
          defaultLocale: tale.localizations.defaultLocale,
          translations: tale.localizations.translations,
          taleId: tale.id,
        ),
      ]);
    }

    final pages = selectedTaleState.pages;
    if (pages.isEmpty) {
      throwException(const ErrorX('Tale must contain at least 1 page.'));
      return null;
    }

    //validate pages
    final arePagesValid = pages.map((e) => e.isValidToSave);

    if (arePagesValid.any((element) => element.isNotEmpty)) {
      throwException(ErrorX(arePagesValid));
      return null;
    } else {
      await taleRepository.saveTalePages(pages);
    }

    final interactions = selectedTaleState.interactions;

    //validate interactions
    final areInteractionsValid = interactions.map((e) => e.isValidToSave);

    if (areInteractionsValid.any((element) => element.isNotEmpty)) {
      throwException(ErrorX(areInteractionsValid));
      return null;
    } else {
      await taleRepository.saveTaleInteractions(selectedTaleState.interactions);
    }

    //todo: handle result

    dispatchAll([
      GetTaleAction(taleId: tale.id),
      GetTaleListAction(),
    ]);

    return null;
  }
}
