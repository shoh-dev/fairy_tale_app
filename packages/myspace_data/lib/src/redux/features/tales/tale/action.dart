import 'dart:async';
import 'dart:developer';

import 'package:myspace_data/myspace_data.dart';

class _TaleAction extends DefautAction {
  final Result<void> taleStatus;
  final Tale? tale;
  final List<TaleLocalization>? localizations;

  _TaleAction({
    this.tale,
    this.localizations,
    required this.taleStatus,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleState: taleState.copyWith(
        selectedTale: tale,
        status: taleStatus,
        localizations: localizations,
      ),
    );
  }
}

class LoadTaleAction extends DefautAction {
  final String taleId;
  final bool reset;

  LoadTaleAction(this.taleId, {this.reset = false});

  @override
  Future<AppState?> reduce() async {
    if (reset) {
      dispatch(_TaleAction(taleStatus: Result.loading()));
      return null;
    }

    final tale = await taleService.getTaleById(taleId);

    await tale.fold(
      (tale) async {
        final localizations = await taleService.getTaleLocalizations(tale.id, "en"); //todo: get from app state
        localizations.fold((locs) {
          dispatch(_TaleAction(
            tale: tale,
            localizations: locs,
            taleStatus: Result.ok(null),
          ));
        }, (error) {
          dispatch(_TaleAction(taleStatus: Result.error(error)));
        });
      },
      (error) {
        dispatch(_TaleAction(taleStatus: Result.error(error)));
      },
      () => dispatch(_TaleAction(taleStatus: Result.loading())),
    );
    return null;
  }
}

class TaleInteractionHandlerAction extends DefautAction {
  final TaleInteraction interaction;

  TaleInteractionHandlerAction(this.interaction);

  @override
  Future<AppState?> reduce() async {
    if (!taleState.status.isOk) {
      return null;
    }

    final tale = taleState.selectedTale;
    final talePage = tale.pages.firstWhereOrNull((e) => e.id == interaction.pageId);

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
          log("Playing sound");
          //todo: test play sound
          final result = await audioPlayerService.playFromUrl("https://www.youtube.com/watch?v=mOVwfhOjUs8");
          print(result);
          return result.fold((success) {
            return handleTap(tale, talePage);
          }, (error) {
            return null;
          });
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