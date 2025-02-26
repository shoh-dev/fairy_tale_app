import 'package:myspace_data/myspace_data.dart' as data;

import 'state.dart';

class ResultStoreConnector extends data.ResultStoreConnector<AppState> {
  const ResultStoreConnector({
    super.key,
    required super.converter,
    required super.builder,
    super.onInitialBuild,
    super.onDispose,
  });
}

class DispatchStoreConnector extends data.DispatchStoreConnector<AppState> {
  DispatchStoreConnector({
    super.key,
    required super.builder,
    super.onInitialBuild,
    super.onDispose,
  });
}
