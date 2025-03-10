import 'dart:async';

import 'package:fairy_tale_mobile/manager/redux/action.dart';
import 'package:fairy_tale_mobile/manager/redux/state.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

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

class GetTaleListAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    dispatch(_Action(listResult: const StateResult.loading()));
    final tales = await taleRepository.getAllTales();
    tales.when(
      ok: (data) =>
          dispatch(_Action(listResult: const StateResult.ok(), list: data)),
      error: (e) => dispatch(_Action(listResult: StateResult.error(e))),
    );
    return null;
  }
}
