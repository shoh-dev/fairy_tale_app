import 'dart:async';
import 'package:myspace_data/src/redux.dart';

class LoadAllTalesAction extends DefautAction {
  @override
  Future<AppState> reduce() async {
    final tales = await taleService.getAllTales();
    return state.copyWith(talesState: talesState.copyWith(tales: tales));
  }
}
