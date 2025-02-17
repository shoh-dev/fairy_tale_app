import 'dart:async';
import 'dart:developer';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:myspace_data/myspace_data.dart';

import 'di/di.dart';

class AppStore {
  const AppStore();

  void registerSingleton<T extends Object>(T di, {bool unregisterIfExists = false}) {
    DependencyInjection.registerSingleton<T>(di, deregisterIfExists: unregisterIfExists);
  }

  Future<void> registerAsyncSingleton<T extends Object>(FactoryFuncAsync<T> di, {bool unregisterIfExists = false}) {
    DependencyInjection.registerAsyncSingleton<T>(di, deregisterIfExists: unregisterIfExists);
    return allReady();
  }

  // void registerSingletonAll(List<Object> diList, {bool deregisterIfExists = false}) {
  //   for (var di in diList) {
  //     registerSingleton<Object>(di, unregisterIfExists: deregisterIfExists);
  //   }
  // }

  Future<void> allReady() {
    return DependencyInjection.allReady();
  }

  T getDependency<T extends Object>() {
    return DependencyInjection.get<T>();
  }

  Future<void> setupDependencies() async {
    registerSingleton(EnvKeysServiceImpl());

    await registerAsyncSingleton(
      () async {
        final supabase = SupabaseServiceImpl(getDependency());
        final client = await supabase.initialize();
        return client.fold((ok) => ok, (e) {
          throw Exception('Error initializing Supabase. $e');
        });
      },
    );

    registerSingleton(TaleServiceImpl(getDependency()));
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
