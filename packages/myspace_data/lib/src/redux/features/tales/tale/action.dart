import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';

class _TaleAction extends DefaultAction {
  final StateResult taleStatus;
  final Tale? tale;

  _TaleAction({
    this.tale,
    required this.taleStatus,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleState: taleState.copyWith(
        selectedTale: tale ?? taleState.selectedTale,
        status: taleStatus,
      ),
    );
  }
}

class GetTaleAction extends DefaultAction {
  final String taleId;
  final bool reset;

  GetTaleAction(
    this.taleId, {
    ///resets TaleState
    this.reset = false,
  });

  @override
  Future<AppState?> reduce() async {
    if (reset) {
      dispatch(_TaleAction(taleStatus: StateResult.loading()));
      return null;
    }

    final tale = await taleService.getTaleById(taleId);

    if (kDebugMode) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    await tale.fold(
      (tale) async {
        dispatch(_TaleAction(
          tale: tale,
          taleStatus: StateResult.ok(),
        ));
      },
      (error) {
        dispatch(_TaleAction(taleStatus: StateResult.error(error)));
      },
    );
    return null;
  }
}

class TaleInteractionHandlerAction extends DefaultAction {
  final TaleInteraction interaction;

  TaleInteractionHandlerAction(this.interaction);

  @override
  Future<AppState?> reduce() async {
    if (!taleState.status.isOk) {
      return null;
    }

    final tale = taleState.selectedTale;
    final talePage = tale.talePages.firstWhereOrNull((e) => e.id == interaction.talePageId);

    if (talePage == null) {
      return null;
    }

    final subType = interaction.eventSubTypeEnum;

    switch (interaction.eventTypeEnum) {
      case TaleInteractionEventType.swipe:
        if (subType
            case TaleInteractionEventSubType.swipeRight ||
                TaleInteractionEventSubType.swipeLeft ||
                TaleInteractionEventSubType.swipeUp ||
                TaleInteractionEventSubType.swipeDown) {
          return handleSwipe(tale, talePage);
        }
      case TaleInteractionEventType.tap:
        if (subType case TaleInteractionEventSubType.playSound) {
          final result =
              await interactionAudioPlayerService.playFromUrl("http://127.0.0.1:54321/storage/v1/object/public/default/abrobey-qimmat-dunyo-mp3.mp3");
          return result.fold(
            (success) {
              return handleTap(tale, talePage);
            },
            (error) {
              return null;
            },
          );
        }
    }
    return null;
  }

  AppState? handleSwipe(Tale tale, TalePage talePage) {
    final newPosition = interaction.finalPosition;
    if (newPosition == null) {
      return null;
    }

    final newInteraction = interaction.updateCurrentPosition(newPosition).updateIsUsed(true);
    final newPage = talePage.updateInteraction(newInteraction);
    final newTale = tale.updatePage(newPage);

    return state.copyWith(taleState: taleState.copyWith(selectedTale: newTale));
  }

  AppState? handleTap(Tale tale, TalePage talePage) {
    final newInteraction = interaction.updateIsUsed(true);
    final newPage = talePage.updateInteraction(newInteraction);
    final newTale = tale.updatePage(newPage);

    return state.copyWith(taleState: taleState.copyWith(selectedTale: newTale));
  }
}

class SelectEmptyTaleAction extends DefaultAction {
  @override
  AppState? reduce() {
    dispatch(_TaleAction(
      tale: Tale.empty,
      taleStatus: StateResult.ok(),
    ));
    return null;
  }
}

class UpdateSelectedTaleAction extends DefaultAction {
  final Tale tale;

  UpdateSelectedTaleAction(this.tale);

  @override
  AppState? reduce() {
    if (tale == taleState.selectedTale) {
      return null;
    }
    return state.copyWith(taleState: taleState.copyWith(selectedTale: tale));
  }
}





  // final oldPos = objectPos;
  // objectPos += value;
  // if (objectPos.dx < 0) {
  //   objectPos = Offset(0, objectPos.dy);
  // } else if (objectPos.dx > (cc.maxWidth - 40)) {
  //   //-40 is the size of the object
  //   objectPos = Offset((cc.maxWidth - 40), objectPos.dy);
  // }
  // if (objectPos.dy < 0) {
  //   objectPos = Offset(objectPos.dx, 0);
  // } else if (objectPos.dy > (cc.maxHeight - 40)) {
  //   //-40 is the size of the object
  //   objectPos = Offset(objectPos.dx, (cc.maxHeight - 40));
  // }
  // if (oldPos != objectPos) {
  //   setState(() {});
  // }