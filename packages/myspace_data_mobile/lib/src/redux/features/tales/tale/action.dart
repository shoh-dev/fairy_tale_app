import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';

class _TaleAction extends DefaultAction {
  final StateResult? selectedTaleResult;
  final Tale? tale;

  _TaleAction({
    this.tale,
    this.selectedTaleResult,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: tale ?? taleState.selectedTale,
          selectedTaleResult: selectedTaleResult ?? taleState.selectedTaleResult,
        ),
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
      dispatch(_TaleAction(selectedTaleResult: StateResult.loading()));
      return null;
    }

    final tale = await taleRepository.getTaleById(taleId);

    if (kDebugMode) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    await tale.fold(
      (tale) async {
        final pages = tale.talePages.map((page) {
          final interactions = page.taleInteractions.map((interaction) {
            return interaction.copyWith(currentPosition: interaction.initialPosition);
          }).toList();
          return page.copyWith(taleInteractions: interactions);
        });

        dispatch(_TaleAction(
          tale: tale.copyWith(talePages: pages.toList()),
          selectedTaleResult: StateResult.ok(),
        ));
      },
      (error) {
        dispatch(_TaleAction(selectedTaleResult: StateResult.error(error)));
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
    if (!taleState.selectedTaleResult.isOk) {
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
              await interactionAudioPlayerRepository.playFromUrl("http://127.0.0.1:54321/storage/v1/object/public/default/abrobey-qimmat-dunyo-mp3.mp3");
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

    return state.copyWith(taleListState: taleListState.copyWith(taleState: taleState.copyWith(selectedTale: newTale)));
  }

  AppState? handleTap(Tale tale, TalePage talePage) {
    final newInteraction = interaction.updateIsUsed(true);
    final newPage = talePage.updateInteraction(newInteraction);
    final newTale = tale.updatePage(newPage);

    return state.copyWith(taleListState: taleListState.copyWith(taleState: taleState.copyWith(selectedTale: newTale)));
  }
}
