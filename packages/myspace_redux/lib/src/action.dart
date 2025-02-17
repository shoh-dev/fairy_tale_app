import 'package:async_redux/async_redux.dart';
import 'package:core_tales/core_tales.dart';
import 'package:myspace_redux/src/di/di.dart';
import 'package:myspace_redux/src/state.dart';

import 'features/tales/state.dart';
import 'features/tales/tale/state.dart';

abstract class DefautAction extends ReduxAction<AppState> {
  T getDependency<T extends Object>() {
    return DependencyInjection.get<T>();
  }

  TalesState get talesState => state.talesState;
  TaleState get taleState => state.taleState;

  TaleServiceImpl get taleService => getDependency<TaleServiceImpl>();
}
