import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/tale_list_state/tale_list_action.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

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
          tale: Tale.newTale(UUID.v4()),
        ),
      );
      return null;
    }

    dispatch(TaleAction(selectedTaleResult: const StateResult.loading()));

    await Future.delayed(const Duration(seconds: 1));

    final tale = await taleRepository.getTaleById(taleId);

    return tale.when(
      ok: (result) {
        return state.copyWith(
          selectedTaleState: selectedTaleState.copyWith(
            tale: result.$1,
            pages: result.$2,
            interactions: result.$3,
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

    // if (taleState.isTaleValidToSave.isNotEmpty) {//todo: handle
    // log('SaveTaleAction: ${taleState.isTaleValidToSave} not valid');
    // return null;
    // }

    dispatch(TaleAction(selectedTaleResult: const StateResult.loading()));

    //todo: handle result
    final taleResult = await taleRepository.saveTale(tale);
    final localizationResult = await taleRepository.saveTaleLocalization(
      defaultLocale: tale.localizations.defaultLocale,
      translations: tale.localizations.translations,
      taleId: tale.id,
    );

    final pagesResult =
        await taleRepository.saveTalePages(selectedTaleState.pages);
    final interactionsResult = await taleRepository
        .saveTaleInteractions(selectedTaleState.interactions);

    Logger('tale').info(taleResult);
    Logger('pages').info(pagesResult);
    Logger('locale').info(localizationResult);
    Logger('interactions').info(interactionsResult);

    dispatchAll([
      // ResetPageAction(),
      GetTaleAction(taleId: tale.id),
      GetTaleListAction(),
    ]);

    return null;
  }
}
