import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class StatusStatusWrapper extends StatelessWidget {
  const StatusStatusWrapper({
    super.key,
    required this.builder,
    required this.converter,
    this.onDispose,
    this.onInitialBuild,
  });

  final Widget Function(BuildContext context, Result<void> result) builder;
  final StoreConverter<AppState, Result<void>> converter;
  final OnDisposeCallback<AppState>? onDispose;
  final OnInitialBuildCallback<AppState, Result<void>>? onInitialBuild;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Result<void>>(
      converter: converter,
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
      builder: (context, vm) => builder(context, vm),
    );
  }
}
