import 'package:async_redux/async_redux.dart' as ar;
import 'package:flutter/widgets.dart';
import 'package:myspace_data/myspace_data.dart';

class StoreConnector<Model> extends StatelessWidget {
  const StoreConnector({
    super.key,
    this.converter,
    required this.builder,
    this.onDispose,
    this.onInitialBuild,
    this.onDidChange,
  });

  final ar.StoreConverter<AppState, Model>? converter;
  final ar.ViewModelBuilder<Model> builder;
  final ar.OnDisposeCallback<AppState>? onDispose;
  final ar.OnInitialBuildCallback<AppState, Model>? onInitialBuild;
  final ar.OnDidChangeCallback<AppState, Model>? onDidChange;

  @override
  Widget build(BuildContext context) {
    return ar.StoreConnector<AppState, Model>(
      converter: converter,
      onDispose: onDispose,
      onInitialBuild: onInitialBuild,
      onDidChange: onDidChange,
      builder: builder,
    );
  }
}
