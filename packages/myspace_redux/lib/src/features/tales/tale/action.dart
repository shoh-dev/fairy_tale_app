import 'dart:async';

import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_redux/myspace_redux.dart';

class _TaleAction extends DefautAction {
  final Tale? tale;
  final Result<void> taleStatus;

  _TaleAction({
    this.tale,
    required this.taleStatus,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleState: taleState.copyWith(
        selectedTale: tale,
        status: taleStatus,
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

    tale.fold(
      (tale) {
        dispatch(_TaleAction(tale: tale, taleStatus: Result.ok(null)));
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
  AppState? reduce() {
    if (!taleState.status.isOk) {
      return null;
    }

    final tale = taleState.selectedTale;
    final talePage = tale.pages.firstWhereOrNull((e) => e.id == interaction.pageId);

    if (talePage == null) {
      return null;
    }

    switch (interaction.eventTypeEnum) {
      case TaleInteractionEventType.swipe:
        if (interaction.eventSubTypeEnum
            case TaleInteractionEventSubType.swipeRight ||
                TaleInteractionEventSubType.swipeLeft ||
                TaleInteractionEventSubType.swipeUp ||
                TaleInteractionEventSubType.swipeDown) {
          final newPosition = interaction.finalPosition;
          if (newPosition == null) {
            return null;
          }

          final newInteraction = interaction.updateCurrentPosition(newPosition).updateIsUsed(true);
          final newPage = talePage.updateInteraction(newInteraction);
          final newTale = tale.updatePage(newPage);

          return state.copyWith(taleState: taleState.copyWith(selectedTale: newTale));
        }

      case TaleInteractionEventType.tap:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
    return null;
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
}
