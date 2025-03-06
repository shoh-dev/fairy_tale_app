import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

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

  GetTaleAction({
    /// if taleId is null, selects an empty tale
    this.taleId = '',
  });

  @override
  Future<AppState?> reduce() async {
    dispatch(_TaleAction(selectedTaleResult: const StateResult.loading()));

    if (taleId.isEmpty) {
      dispatch(
        _TaleAction(
          selectedTaleResult: const StateResult.ok(),
          tale: Tale.empty,
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
            return interaction.copyWith(
              currentPosition: interaction.initialPosition,
            );
          }).toList();
          return page.copyWith(interactions: interactions);
        });

        dispatch(
          _TaleAction(
            tale: tale.copyWith(pages: pages.toList()),
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

class SaveTaleAction extends DefaultAction {
  final Tale tale;

  SaveTaleAction(this.tale);
  //todo: save on db

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
