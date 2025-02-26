import 'package:myspace_data/myspace_data.dart' as data;
import 'package:flutter/widgets.dart';

import 'state.dart';

class StoreConnector<Model> extends data.StoreConnector<AppState, Model> {
  const StoreConnector({
    super.key,
    required super.converter,
    required super.builder,
    super.onDidChange,
    super.onDispose,
    super.onInitialBuild,
    super.rebuildOnChange,
    super.isDistinct,
  });

  @override
  Widget build(BuildContext context) {
    return data.StoreConnector<AppState, Model>(
      rebuildOnChange: rebuildOnChange,
      isDistinct: isDistinct,
      converter: converter,
      onDispose: onDispose,
      onInitialBuild: onInitialBuild,
      onDidChange: onDidChange,
      builder: builder,
    );
  }
}
