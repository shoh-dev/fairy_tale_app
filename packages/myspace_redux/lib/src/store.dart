import 'dart:developer';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:myspace_redux/src/state.dart';

import 'di/di.dart';

class AppStore {
  const AppStore();

  void registerSingleton<T extends Object>(T di, {bool unregisterIfExists = false}) {
    DependencyInjection.registerSingleton<T>(di, deregisterIfExists: unregisterIfExists);
  }

  void registerSingletonAll(List<Object> diList, {bool deregisterIfExists = false}) {
    for (var di in diList) {
      DependencyInjection.registerSingleton<Object>(di);
    }
  }

  T getDependency<T extends Object>() {
    return DependencyInjection.get<T>();
  }

  Store<AppState> createStore() {
    log('Creating store...');
    final store = Store<AppState>(
      actionObservers: [
        if (kDebugMode) Log.printer(formatter: Log.verySimpleFormatter),
      ],
      initialState: AppState.initial(),
    );

    registerSingleton(store);

    return store;
  }
}
