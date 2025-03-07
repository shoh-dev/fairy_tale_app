import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

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
    /// if taleId is null, selects an empty tale
    this.taleId = '',
  });

  @override
  Future<AppState?> reduce() async {
    dispatch(TaleAction(selectedTaleResult: const StateResult.loading()));

    if (taleId.isEmpty) {
      dispatch(
        TaleAction(
          selectedTaleResult: const StateResult.ok(),
          tale: Tale.newTale(
            id: UUID.v4(),
          ),
        ),
      );
      return state.copyWith(
        taleListState: taleListState.copyWith(
          taleState: taleState.copyWith(
            isTaleEdited: false,
          ),
        ),
      );
    }

    final tale = await taleRepository.getTaleById(taleId);

    if (kDebugMode) {
      // ignored for now while development
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(milliseconds: 500));
    }

    await tale.when(
      ok: (tale) async {
        final pages = tale.pages.map((page) {
          final interactions = page.interactions.map((interaction) {
            return interaction
                .updateCurrentPosition(interaction.initialPosition);
          }).toList();
          return page.copyWith(interactions: interactions);
        });

        dispatch(
          TaleAction(
            tale: tale.copyWith(pages: pages.toList()),
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

class SetIsTaleEditedAction extends DefaultAction {
  final Tale? newTale;

  SetIsTaleEditedAction({
    required this.newTale,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          isTaleEdited: newTale != taleState.selectedTale,
        ),
      ),
    );
  }
}

class UpdateSelectedTaleAction extends DefaultAction {
  final Tale tale;

  UpdateSelectedTaleAction(this.tale);

  @override
  AppState reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: tale,
          isTaleEdited: false,
        ),
      ),
    );
  }
}

class AddSelectedTaleCoverImageAction extends DefaultAction {
  final PlatformFile file;

  AddSelectedTaleCoverImageAction(this.file);

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
        dispatch(
          UpdateSelectedTaleAction(
            tale.copyWith(
              coverImage: url,
              toReRender: tale.toReRender + 1,
            ),
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

class AddSelectedTalePageBackgroundImageAction extends DefaultAction {
  final PlatformFile file;

  AddSelectedTalePageBackgroundImageAction(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final page = taleState.editorState.selectedTalePage;

    final uploadedResult = await taleRepository.uploadImage(
      bytes: await file.xFile.readAsBytes(),
      path:
          'page_images/background/${page.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(
          UpdateSelectedTalePageAction(
            page.copyWith(
              metadata: page.metadata.copyWith(backgroundImageUrl: url),
              toReRender: page.toReRender + 1,
            ),
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
