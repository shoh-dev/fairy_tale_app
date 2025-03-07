import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/editor_action.dart';
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

  UpdateTaleAction({
    /// when passed as true, re renders all StoreConnectors using selectedTale
    this.reRender = false,
    this.title,
    this.description,
    this.orientation,
    this.coverImageFile,
    this.coverImageUrl,
  });

  @override
  AppState? reduce() {
    final tale = taleState.selectedTale;

    if (coverImageFile != null) {
      dispatch(_UpdateTaleCoverImageActionV2(coverImageFile!));
      return null;
    }

    final newTale = tale.copyWith(
      title: title ?? tale.title,
      description: description ?? tale.description,
      orientation: orientation ?? tale.orientation,
      metadata: tale.metadata.copyWith(
        coverImageUrl: coverImageUrl ?? tale.metadata.coverImageUrl,
      ),
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

class _UpdateTaleCoverImageActionV2 extends DefaultAction {
  final PlatformFile file;

  _UpdateTaleCoverImageActionV2(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final tale = taleState.selectedTale;

    final uploadedResult = await taleRepository.uploadImage(
      bytes: await file.xFile.readAsBytes(),
      path: 'covers/${tale.id}.${file.extension!.toLowerCase()}',
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

/// TEST DONE UP TO HERE

class AddSelectedInteractionImageAction extends DefaultAction {
  final PlatformFile file;

  AddSelectedInteractionImageAction(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final ineraction = taleState.editorState.selectedInteraction;

    final uploadedResult = await taleRepository.uploadImage(
      bytes: await file.xFile.readAsBytes(),
      path:
          'interaction_objects/${ineraction.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(
          UpdateSelectedInteractionAction(
            ineraction.copyWith(
              metadata: ineraction.metadata.copyWith(imageUrl: url),
              toReRender: ineraction.toReRender + 1,
            ),
          ),
        );

        dispatch(SaveInteractionsAction());
      },
      error: (error) {
        // dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
        //todo:
      },
    );
    return null;
  }
}
