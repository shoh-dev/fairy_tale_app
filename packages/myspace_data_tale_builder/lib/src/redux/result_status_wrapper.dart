import 'package:async_redux/async_redux.dart' as ar;
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class ResultStatusWrapper extends StatelessWidget {
  const ResultStatusWrapper({
    super.key,
    required this.converter,
    required this.builder,
    this.onDispose,
    this.onInitialBuild,
  });

  final ar.StoreConverter<AppState, StateResult> converter;
  final Widget Function(BuildContext context, StateResult result) builder;
  final ar.OnDisposeCallback<AppState>? onDispose;
  final ar.OnInitialBuildCallback<AppState, StateResult>? onInitialBuild;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<StateResult>(
      converter: converter,
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
      builder: (context, vm) => builder(context, vm),
    );
  }
}
