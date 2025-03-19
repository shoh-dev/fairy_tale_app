import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/redux/redux/action.dart';
import 'package:shared/src/redux/redux/state.dart';
import 'package:uuid/v4.dart';

class ResetInteractionAction extends DefaultAction {
  @override
  AppState? reduce() {
    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        selectedInteractionId: '',
      ),
    );
  }
}

class SelectInteractionAction extends DefaultAction {
  final String id;

  SelectInteractionAction(this.id);

  @override
  Future<AppState?> reduce() async {
    if (selectedTaleState.selectedInteractionId == id) {
      return null;
    }

    dispatch(ResetInteractionAction());

    return Future.delayed(const Duration(milliseconds: 100), () {
      return state.copyWith(
        selectedTaleState: selectedTaleState.copyWith(
          selectedInteractionId: id,
        ),
      );
    });
  }
}

class AddInteractionAction extends DefaultAction {
  late final TaleInteraction _newInteraction;

  @override
  AppState? reduce() {
    final page = selectedTaleState.selectedPage;
    if (page == null) {
      return null;
    }

    _newInteraction = TaleInteraction.newInteraction(
      id: const UuidV4().generate(),
      talePageId: page.id,
    );

    final newInteractions = [
      ...selectedTaleState.interactions,
      _newInteraction
    ];

    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        interactions: newInteractions,
      ),
    );
  }

  @override
  void after() {
    dispatch(SelectInteractionAction(_newInteraction.id));
    super.after();
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
  final bool? use;
  final String? id;

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
    this.animationDuration,
    this.imageFile,
    this.imageUrl,
    this.audioFile,
    this.audioUrl,
    this.use,
    this.id,
  });

  @override
  AppState? reduce() {
    if (use == false) {
      final newInteractions = selectedTaleState.interactions.map((e) {
        return e.unuse();
      });

      return state.copyWith(
        selectedTaleState: selectedTaleState.copyWith(
          interactions: newInteractions.toList(),
        ),
      );
    }

    final interaction =
        selectedTaleState.interactions.firstWhereOrNull((e) => e.id == id) ??
            selectedTaleState.selectedInteraction;

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

    newInteraction =
        newInteraction.updateCurrentPosition(newInteraction.initialPosition);

    //2. update selected page interactions with new selected interaction
    final newInteractions = selectedTaleState.interactions.map((e) {
      if (e.id == interaction.id) {
        if (use == true) {
          return newInteraction.use();
        }
        return newInteraction;
      }
      return e;
    });

    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        interactions: newInteractions.toList(),
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

    final ineraction = selectedTaleState.selectedInteraction;

    if (ineraction == null) {
      return null;
    }

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path:
          'interaction/images/${ineraction.id}.${file.extension!.toLowerCase()}',
    );

    return uploadedResult.when(
      ok: (url) {
        dispatch(UpdateInteractionAction(imageUrl: url, reRender: true));
        return null;
      },
      error: (error) {
        // dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
        //todo:
        return null;
      },
    );
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

    final ineraction = selectedTaleState.selectedInteraction;

    if (ineraction == null) {
      return null;
    }

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path:
          'interaction/audios/${ineraction.id}.${file.extension!.toLowerCase()}',
    );

    return uploadedResult.when(
      ok: (url) {
        dispatch(UpdateInteractionAction(audioUrl: url));
        return null;
      },
      error: (error) {
        // dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
        //todo:
        return null;
      },
    );
  }
}

class DeleteInteractionAction extends DefaultAction {
  final TaleInteraction interaction;

  DeleteInteractionAction(this.interaction);

  @override
  Future<AppState?> reduce() async {
    if (interaction.isNew) {
      final newInteractions = selectedTaleState.interactions
          .where((e) => e.id != interaction.id)
          .toList();

      return state.copyWith(
        selectedTaleState: selectedTaleState.copyWith(
          interactions: newInteractions,
          selectedInteractionId: '',
        ),
      );
    }

    final deleteResult =
        await taleRepository.deleteInteractionAction(interaction.id);

    return deleteResult.when(
      ok: (_) {
        final newInteractions = selectedTaleState.interactions
            .where((e) => e.id != interaction.id)
            .toList();

        return state.copyWith(
          selectedTaleState: selectedTaleState.copyWith(
            interactions: newInteractions,
            selectedInteractionId: '',
          ),
        );
      },
      error: (error) {
        final newInteractions = selectedTaleState.interactions
            .where((e) => e.id != interaction.id)
            .toList();

        return state.copyWith(
          selectedTaleState: selectedTaleState.copyWith(
            interactions: newInteractions,
            selectedInteractionId: '',
          ),
        );
      },
    );
  }
}
