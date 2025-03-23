import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';
import 'package:shared/src/redux/redux/action.dart';
import 'package:shared/src/redux/redux/state.dart';

class _Action extends DefaultAction {
  final StateResult? listResult;
  final List<Tale>? list;

  _Action({this.listResult, this.list});

  @override
  AppState? reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        listResult: listResult ?? taleListState.listResult,
        list: list ?? taleListState.list,
      ),
    );
  }
}

class UpdateSearchQueryAction extends DefaultAction {
  final String query;

  UpdateSearchQueryAction(this.query);

  @override
  AppState? reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        searchQuery: query,
      ),
    );
  }

  @override
  void after() {
    if (taleListState.searchQuery.isEmpty) {
      dispatch(GetTaleListAction());
    }
    super.after();
  }
}

class GetTaleListAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    dispatch(_Action(listResult: const StateResult.loading()));
    final tales = await taleRepository.getTales(
      searchQuery: taleListState.searchQuery,
    );
    tales.when(
      ok: (data) =>
          dispatch(_Action(listResult: const StateResult.ok(), list: data)),
      error: (e) => dispatch(_Action(listResult: StateResult.error(e))),
    );
    return null;
  }
}
