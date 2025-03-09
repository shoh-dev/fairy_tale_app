import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/tale_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared/shared.dart';

class ResetInteractinAction extends DefaultAction {
  @override
  AppState? reduce() {
    if (taleState.editorState.selectedInteractionId.isEmpty) {
      return null;
    }

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedInteractionId: '',
          ),
        ),
      ),
    );
  }
}

class SelectInteractionAction extends DefaultAction {
  final String id;

  SelectInteractionAction(this.id);

  @override
  AppState? reduce() {
    if (editorState.selectedInteractionId == id) {
      return null;
    }

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedInteractionId: id,
          ),
        ),
      ),
    );
  }
}

class AddInteractionAction extends DefaultAction {
  @override
  AppState? reduce() {
    final tale = taleState.tale;
    final page = taleState.selectedPage;
    if (page == null) {
      return null;
    }

    final newInteraction = TaleInteraction.newInteraction(
      id: UUID.v4(),
      talePageId: page.id,
    );

    final newPage = page.copyWith(
      interactions: [...page.interactions, newInteraction],
    );

    final newPages =
        tale.pages.map((e) => e.id == page.id ? newPage : e).toList();
    dispatch(UpdateTaleAction(pages: newPages));
    return null; //todo: test
  }
}

class UpdateInteractionAction extends DefaultAction {
  final bool reRender;

  final String? hintKey;
  final num? width;
  final num? height;
  final num? initialdx;
  final num? initialdy;
  final num? finaldx;
  final num? finaldy;
  final String? eventType;
  final String? eventSubType;
  final String? action;
  final int? animationDuration;
  final PlatformFile? imageFile;
  final String? imageUrl;
  final PlatformFile? audioFile;
  final String? audioUrl;

  UpdateInteractionAction({
    /// when passed as true, re renders all StoreConnectors using selectedTale
    this.reRender = false,
    this.hintKey,
    this.width,
    this.height,
    this.initialdx,
    this.initialdy,
    this.eventType,
    this.eventSubType,
    this.action,
    this.finaldx,
    this.finaldy,
    this.animationDuration, //todo:
    this.imageFile,
    this.imageUrl,
    this.audioFile,
    this.audioUrl,
  });

  @override
  AppState? reduce() {
    final tale = taleState.tale;

    final page = taleState.selectedPage;
    if (page == null) {
      return null;
    }

    final interaction = taleState.selectedInteraction;
    if (interaction == null) {
      return null;
    }

    if (imageFile != null) {
      dispatch(_UpdateInteractionImageAction(imageFile!));
      return null;
    }

    if (audioFile != null) {
      dispatch(_UpdateInteractionAudioAction(audioFile!));
      return null;
    }

    //steps:
    //1. update selected interaction
    var newInteraction = interaction.copyWith(
      toReRender:
          reRender ? interaction.toReRender + 1 : interaction.toReRender,
      hintKey: hintKey ?? interaction.hintKey,
      eventType: eventType ?? interaction.eventType,
      eventSubtype: eventSubType ?? interaction.eventSubtype,
      animationDuration: animationDuration ?? interaction.animationDuration,
      action: action ?? interaction.action,
      metadata: interaction.metadata.copyWith(
        imageUrl: imageUrl ?? interaction.metadata.imageUrl,
        audioUrl: audioUrl ?? interaction.metadata.audioUrl,
        size: interaction.metadata.size.copyWith(
          w: width ?? interaction.metadata.size.width,
          h: height ?? interaction.metadata.size.height,
        ),
        initialPosition: interaction.metadata.initialPosition.copyWith(
          x: initialdx ?? interaction.metadata.initialPosition.dx,
          y: initialdy ?? interaction.metadata.initialPosition.dy,
        ),
        // currentPosition: initialdx != null || initialdy != null
        //     ? interaction.metadata.initialPosition.copyWith(
        //         x: initialdx ?? interaction.metadata.initialPosition.dx,
        //         y: initialdy ?? interaction.metadata.initialPosition.dy,
        //       )
        //     : interaction.metadata.currentPosition,
        finalPosition: interaction.metadata.finalPosition?.copyWith(
          x: finaldx ?? interaction.metadata.finalPosition?.dx ?? 0,
          y: finaldy ?? interaction.metadata.finalPosition?.dy ?? 0,
        ),
      ),
    );

    if (finaldx != null || finaldy != null) {
      var finalPos =
          newInteraction.metadata.finalPosition ?? TaleInteractionPosition.zero;

      finalPos = finalPos.copyWith(
        x: finaldx ?? finalPos.dx,
        y: finaldy ?? finalPos.dy,
      );

      newInteraction = newInteraction.copyWith(
        metadata: newInteraction.metadata.copyWith(
          finalPosition: finalPos,
        ),
      );
    }

    //2. update selected page interactions with new selected interaction
    final newInteractions = page.interactions.map((e) {
      if (e.id == interaction.id) {
        return newInteraction.copyWith(
          metadata: newInteraction.metadata.copyWith(
            currentPosition: newInteraction.metadata.initialPosition,
          ),
        );
      }
      return e;
    });
    final newPage = page.copyWith(interactions: newInteractions.toList());

    //3. update tale pages with new selected page
    final newTalePages = tale.pages.map((e) {
      if (e.id == page.id) {
        return newPage;
      }
      return e;
    });

    dispatch(
      UpdateTaleAction(
        pages: newTalePages.toList(),
        reRender: imageUrl != null,
      ),
    );
  }
}

class _UpdateInteractionImageAction extends DefaultAction {
  final PlatformFile file;

  _UpdateInteractionImageAction(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final ineraction = taleState.selectedInteraction;

    if (ineraction == null) {
      return null;
    }

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path:
          'interaction/images/${ineraction.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(UpdateInteractionAction(imageUrl: url, reRender: true));
      },
      error: (error) {
        // dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
        //todo:
      },
    );
    return null;
  }
}

class _UpdateInteractionAudioAction extends DefaultAction {
  final PlatformFile file;

  _UpdateInteractionAudioAction(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final ineraction = taleState.selectedInteraction;

    if (ineraction == null) {
      return null;
    }

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path:
          'interaction/audios/${ineraction.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(UpdateInteractionAction(audioUrl: url));
      },
      error: (error) {
        // dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
        //todo:
      },
    );
    return null;
  }
}

//! UPDATE FROM HERE

class DeleteInteractionAction extends DefaultAction {
  final TaleInteraction interaction;

  DeleteInteractionAction(this.interaction);

  @override
  Future<AppState?> reduce() async {
    if (interaction.isNew) {
      final selectedPage = taleState.selectedPage;
      if (selectedPage == null) {
        return null;
      }

      final newInteractions = selectedPage.interactions
          .where((e) => e.id != interaction.id)
          .toList();

      final newPage = selectedPage.copyWith(interactions: newInteractions);

      final newPages = taleState.tale.pages
          .map((e) => e.id == selectedPage.id ? newPage : e)
          .toList();

      dispatch(UpdateTaleAction(pages: newPages));
      dispatch(ResetInteractinAction());

      return null;
    }

    // final deleteResult =
    // await taleRepository.deleteInteractionAction(interaction.id);
//
    // deleteResult.when(
    // ok: (_) {
    // final newPages = taleState.selectedTale.pages
    // .where((e) => e.id != selectedPage.id)
    // .toList();
    // dispatchAll([
    // SelectPageAction(),
    // UpdateTaleAction(pages: newPages.toList()),
    // ]);
    // },
    // error: (error) {
    // dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
    // },
    // );
//
    // return null;//todo:
  }
}
