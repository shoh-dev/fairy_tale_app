import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_redux/myspace_redux.dart';

class LoadAllTalesAction extends DefautAction {
  @override
  Future<AppState> reduce() async {
    final tales = await taleService.getAllTales();
    return state.copyWith(talesState: talesState.copyWith(tales: tales));
  }
}

class _TaleAction extends DefautAction {
  final Result<Tale> result;

  _TaleAction(this.result);

  @override
  AppState reduce() {
    return state.copyWith(talesState: talesState.copyWith(selectedTale: result));
  }
}

class LoadTaleAction extends DefautAction {
  final String taleId;
  final bool reset;

  LoadTaleAction(this.taleId, {this.reset = false});

  @override
  Future<AppState?> reduce() async {
    dispatch(_TaleAction(Result.loading()));
    if (reset) {
      return null;
    }
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 1));
      print('LoadTaleAction: $taleId');
    }
    final tale = await taleService.getTaleById(taleId);
    dispatch(_TaleAction(tale));
    return null;
  }
}

class UpdateSelectedTaleInteractionAction extends DefautAction {
  final Offset? newOffset;
}
