import 'dart:async';

import 'package:fairy_tale_mobile/manager/redux.dart';
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
    // ignored for now while development
    // ignore: inference_failure_on_instance_creation
    await Future.delayed(const Duration(seconds: 1));
    tales.when(
      ok: (data) => dispatch(
        _Action(taleListResult: const StateResult.ok(), taleList: data),
      ),
      error: (e) => dispatch(_Action(taleListResult: StateResult.error(e))),
    );
    return null;
  }
}
