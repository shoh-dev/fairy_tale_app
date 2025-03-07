import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class _Action extends DefaultAction {
  final StateResult? taleListResult;
  final List<Tale>? taleList;

  _Action({this.taleListResult, this.taleList});

  @override
  AppState? reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleListResult: taleListResult ?? taleListState.taleListResult,
        taleList: taleList ?? taleListState.taleList,
      ),
    );
  }
}

class GetTaleListAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    dispatch(_Action(taleListResult: const StateResult.loading()));
    final tales = await taleRepository.getAllTales();
    tales.when(
      ok: (data) => dispatch(
        _Action(taleListResult: const StateResult.ok(), taleList: data),
      ),
      error: (e) => dispatch(_Action(taleListResult: StateResult.error(e))),
    );
    return null;
  }
}
