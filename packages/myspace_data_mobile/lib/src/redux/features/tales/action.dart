import 'dart:async';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/src/redux.dart';
import 'package:myspace_data_mobile/src/repositories/tale/models.dart';

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
    ));
  }
}

class GetTaleListAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    dispatch(_Action(taleListResult: StateResult.loading()));
    final tales = await taleRepository.getAllTales();
    await Future.delayed(const Duration(seconds: 1));
    tales.fold(
      (data) => dispatch(_Action(taleListResult: StateResult.ok(), taleList: data)),
      (e) => dispatch(_Action(taleListResult: StateResult.error(e))),
    );
    return null;
  }
}
