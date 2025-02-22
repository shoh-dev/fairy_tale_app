import 'dart:async';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data/src/redux.dart';

class _Action extends DefaultAction {
  final Result<void>? result;
  final List<Tale>? tales;

  _Action({this.result, this.tales});

  @override
  AppState? reduce() {
    return state.copyWith(
        talesState: talesState.copyWith(
      status: result ?? talesState.status,
      tales: tales ?? talesState.tales,
    ));
  }
}

class GetAllTalesAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    dispatch(_Action(result: Result.loading()));
    final tales = await taleService.getAllTales();
    tales.fold(
      (data) => dispatch(_Action(result: Result.ok(null), tales: data)),
      (e) => dispatch(_Action(result: Result.error(e))),
    );
    return null;
  }
}
