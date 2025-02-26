import 'package:myspace_data/myspace_data.dart' as data;

import 'state.dart';

class ResultStatusWrapper extends data.ResultStatusWrapper<AppState> {
  const ResultStatusWrapper({
    super.key,
    required super.converter,
    required super.builder,
    super.onInitialBuild,
    super.onDispose,
  });
}
