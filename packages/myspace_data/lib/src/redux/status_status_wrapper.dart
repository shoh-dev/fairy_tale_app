import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class StatusStatusWrapper extends StatelessWidget {
  const StatusStatusWrapper({
    super.key,
    required this.converter,
    required this.builder,
    this.onDispose,
    this.onInitialBuild,
  });

  final StoreConverter<AppState, StateResult> converter;
  final Widget Function(BuildContext context, StateResult result) builder;
  final OnDisposeCallback<AppState>? onDispose;
  final OnInitialBuildCallback<AppState, StateResult>? onInitialBuild;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StateResult>(
      converter: converter,
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
      builder: (context, vm) => builder(context, vm),
    );
  }
}
