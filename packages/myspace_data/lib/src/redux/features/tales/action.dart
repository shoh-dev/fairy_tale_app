import 'dart:async';
import 'package:myspace_data/myspace_data.dart';

class _Action extends DefaultAction {
  final StateResult? result;
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
    dispatch(_Action(result: StateResult.loading()));
    final tales = await taleService.getAllTales();
    tales.fold(
      (data) => dispatch(_Action(result: StateResult.ok(), tales: data)),
      (e) => dispatch(_Action(result: StateResult.error(e))),
    );
    return null;
  }
}
