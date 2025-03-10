import 'dart:async';

import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

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
      return state.copyWith(selectedTaleState: SelectedTaleState.initial());
    }

    final tale = await taleRepository.getTaleById(taleId);

    if (kDebugMode) {
      // ignored for now while development
      // ignore: inference_failure_on_instance_creation
      await Future.delayed(const Duration(milliseconds: 500));
    }

    return tale.when(
      ok: (tale) {
        return state.copyWith(
          selectedTaleState: state.selectedTaleState.copyWith(
            tale: tale.$1,
            interactions: tale.$3,
            pages: tale.$2,
            taleResult: const StateResult.ok(),
          ),
        );
      },
      error: (error) {
        return state.copyWith(
          selectedTaleState: state.selectedTaleState.copyWith(
            taleResult: StateResult.error(error),
          ),
        );
      },
    );
  }
}

class TaleInteractionHandlerAction extends DefaultAction {
  final TaleInteraction interaction;

  TaleInteractionHandlerAction(this.interaction);

  @override
  Future<AppState?> reduce() async {
    if (!selectedTaleState.taleResult.isOk) {
      return null;
    }

    final tale = selectedTaleState.tale;
    final talePage = selectedTaleState.pages
        .firstWhereOrNull((e) => e.id == interaction.talePageId);

    if (talePage == null) {
      return null;
    }

    if (interaction.eventTypeEnum == null) {
      return null;
    }

    if (interaction.actionEnum == null) {
      return null;
    }

    switch (interaction.actionEnum!) {
      case TaleInteractionAction.playSound:
        if (!interaction.metadata.hasAudio) {
          return _missingAudio();
        }
        unawaited(interaction.playAudio());
        return makeUsed(tale);
      case TaleInteractionAction.move:
        if (interaction.metadata.finalPosition == null) {
          return _missingFinalPosition();
        }
        return handleSwipe(tale);
    }
  }

  AppState _missingAudio() {
    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        taleResult: StateResult.error(
          ErrorX(
            '[${interaction.id}]:\nMissing audio',
          ),
        ),
      ),
    );
  }

  AppState _missingFinalPosition() {
    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        taleResult: StateResult.error(
          ErrorX(
            '[${interaction.id}]:\nMissing final_pos',
          ),
        ),
      ),
    );
  }

  AppState? handleSwipe(Tale tale) {
    final newPosition = interaction.finalPosition;
    if (newPosition == null) {
      return null;
    }

    final newInteraction =
        interaction.updateCurrentPosition(newPosition).updateIsUsed(true);

    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        interactions: selectedTaleState.interactions
            .map((e) => e.id == interaction.id ? newInteraction : e)
            .toList(),
      ),
    );
  }

  AppState? makeUsed(Tale tale) {
    final newInteraction = interaction.updateIsUsed(true);

    return state.copyWith(
      selectedTaleState: selectedTaleState.copyWith(
        interactions: selectedTaleState.interactions
            .map((e) => e.id == interaction.id ? newInteraction : e)
            .toList(),
      ),
    );
  }
}
