import 'dart:async';

import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myspace_data/myspace_data.dart';

mixin DispatchConnectorMixin on StatelessWidget {
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
  );
  FutureOr<void> onInitialBuild(Dispatcher<AppState> dispatch) {}
  FutureOr<void> onDispose(Dispatcher<AppState> dispatch) {}

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return DispatchConnector<AppState>(
      builder: builder,
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
    );
  }
}

mixin DispatchConnectorMixinState<T extends StatefulWidget> on State<T> {
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
  );

  FutureOr<void> onInitialBuild(Dispatcher<AppState> dispatch) {}
  FutureOr<void> onDispose(Dispatcher<AppState> dispatch) {}

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return DispatchConnector<AppState>(
      builder: builder,
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
    );
  }
}

mixin StateConnectorMixin<T> on StatelessWidget {
  T selector(AppState state);
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    T model,
  );

  FutureOr<void> onInitialBuild(
    Dispatcher<AppState> dispatch,
    T model,
  ) {}

  FutureOr<void> onDidChange(
    Dispatcher<AppState> dispatch,
    AppState state,
    T model,
  ) {}

  FutureOr<void> onDispose(Dispatcher<AppState> dispatch) {}

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, T>(
      selector: selector,
      builder: builder,
      onDidChange: onDidChange,
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
    );
  }
}

mixin StateResultConnectorMixin on StatelessWidget {
  StateResult selector(AppState state);
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    StateResult result,
  );

  FutureOr<void> onInitialBuild(
    Dispatcher<AppState> dispatch,
    StateResult result,
  ) {}

  FutureOr<void> onDidChange(
    Dispatcher<AppState> dispatch,
    AppState state,
    StateResult result,
  ) {}

  FutureOr<void> onDispose(Dispatcher<AppState> dispatch) {}

  @nonVirtual
  @override
  Widget build(BuildContext context) {
    return StateResultConnector<AppState>(
      selector: selector,
      builder: builder,
      onDidChange: onDidChange,
      onInitialBuild: onInitialBuild,
      onDispose: onDispose,
    );
  }
}
