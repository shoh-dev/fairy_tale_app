import 'dart:async';

import 'package:fairy_tale_app/manager/redux.dart';
import 'package:fairy_tale_app/manager/repositories/tale/models.dart';
import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';

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
          selectedTaleResult:
              selectedTaleResult ?? taleState.selectedTaleResult,
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
      dispatch(_TaleAction(selectedTaleResult: const StateResult.loading()));
      return null;
    }

    final tale = await taleRepository.getTaleById(taleId);

    if (kDebugMode) {
      // ignored for now while development
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(milliseconds: 500));
    }

    await tale.when(
      ok: (tale) async {
        final pages = tale.talePages.map((page) {
          final interactions = page.taleInteractions.map((interaction) {
            return interaction.copyWith(
              currentPosition: interaction.initialPosition,
            );
          }).toList();
          return page.copyWith(taleInteractions: interactions);
        });

        dispatch(
          _TaleAction(
            tale: tale.copyWith(talePages: pages.toList()),
            selectedTaleResult: const StateResult.ok(),
          ),
        );
      },
      error: (error) {
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
    final talePage =
        tale.talePages.firstWhereOrNull((e) => e.id == interaction.talePageId);

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
        } else {
          _invalidType();
        }
      case TaleInteractionEventType.tap:
        if (subType case TaleInteractionEventSubType.playSound) {
          if (!interaction.metadata.hasAudio) {
            _missingAudio();
            return null;
          }
          final result = await interactionAudioPlayerService
              .playFromUrl(interaction.metadata.audioUrl);
          return result.when(
            ok: (success) {
              return handleTap(tale, talePage);
            },
            error: (error) {
              return null;
            },
          );
        } else {
          _invalidType();
        }
    }
    return null;
  }

  void _invalidType() {
    dispatch(
      _TaleAction(
        selectedTaleResult: StateResult.error(
          ErrorX(
            //
            // ignore: lines_longer_than_80_chars
            '[${interaction.id}]:\nInvalid [${interaction.eventType}] event type for [${interaction.eventSubtype}] subtype',
          ),
        ),
      ),
    );
  }

  void _missingAudio() {
    dispatch(
      _TaleAction(
        selectedTaleResult: StateResult.error(
          ErrorX(
            '[${interaction.id}]:\nMissing audio',
          ),
        ),
      ),
    );
  }

  AppState? handleSwipe(Tale tale, TalePage talePage) {
    final newPosition = interaction.finalPosition;
    if (newPosition == null) {
      return null;
    }

    final newInteraction =
        interaction.updateCurrentPosition(newPosition).updateIsUsed(true);
    final newPage = talePage.updateInteraction(newInteraction);
    final newTale = tale.updatePage(newPage);

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(selectedTale: newTale),
      ),
    );
  }

  AppState? handleTap(Tale tale, TalePage talePage) {
    final newInteraction = interaction.updateIsUsed(true);
    final newPage = talePage.updateInteraction(newInteraction);
    final newTale = tale.updatePage(newPage);

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(selectedTale: newTale),
      ),
    );
  }
}
