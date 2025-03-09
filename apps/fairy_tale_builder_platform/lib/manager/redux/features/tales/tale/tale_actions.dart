import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
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
      GetTaleAction(),
      SelectPageAction(),
      SelectInteractionAction(),
    ]);

    return null;
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
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: tale ?? taleState.selectedTale,
          selectedTaleResult:
              selectedTaleResult ?? taleState.selectedTaleResult,
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
    final tale = taleState.selectedTale;

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
          selectedTale: newTale.copyWith(
            toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
          ),
          isTaleEdited: false, //todo:
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

    final tale = taleState.selectedTale;

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

    final tale = taleState.selectedTale;

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path:
          'tale/background_audios/${tale.id}.${file.extension!.toLowerCase()}',
    );

    print(uploadedResult);

    uploadedResult.when(
      ok: (url) {
        dispatch(UpdateTaleAction(backgroundAudioUrl: url, reRender: true));
      },
      error: (error) {
        dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
      },
    );
    return null;
  }
}
