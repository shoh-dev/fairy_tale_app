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
  final String? taleId;
  final bool reset;

  GetTaleAction(
    /// if taleId is null, selects an empty tale
    this.taleId, {
    ///resets TaleState
    this.reset = false,
  });

  @override
  Future<AppState?> reduce() async {
    if (reset) {
      dispatch(_TaleAction(selectedTaleResult: const StateResult.loading()));
    }
    if (taleId == null) {
      dispatch(
        _TaleAction(
          selectedTaleResult: const StateResult.ok(),
          tale: Tale.empty,
        ),
      );
      return null;
    }

    final tale = await taleRepository.getTaleById(taleId!);

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
