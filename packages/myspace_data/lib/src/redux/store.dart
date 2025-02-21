import 'dart:async';
import 'dart:developer';

import 'package:async_redux/async_redux.dart';
import 'package:core_audio/core_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data/src/repos/application_service.dart';

import 'di/di.dart';

class AppStore {
  const AppStore({
    this.enableActionLog = true,
  });

  final bool enableActionLog;

  void registerSingleton<T extends Object>(T di, {bool unregisterIfExists = false}) {
    DependencyInjection.registerSingleton<T>(di, deregisterIfExists: unregisterIfExists);
  }

  Future<void> registerAsyncSingleton<T extends Object>(FactoryFuncAsync<T> di, {bool unregisterIfExists = false}) {
    DependencyInjection.registerAsyncSingleton<T>(di, deregisterIfExists: unregisterIfExists);
    return allReady();
  }

  Future<void> allReady() {
    return DependencyInjection.allReady();
  }

  T getDependency<T extends Object>() {
    return DependencyInjection.get<T>();
  }

  Future<void> setupDependencies() async {
    registerSingleton(EnvKeysServiceImpl());
    registerSingleton(PathServiceImpl());
    registerSingleton(SystemServiceImpl());
    registerSingleton(MainAudioPlayerServiceImpl());
    registerSingleton(InteractionAudioPlayerServiceImpl());

    await registerAsyncSingleton(
      () async {
        final supabase = SupabaseServiceImpl(getDependency());
        final client = await supabase.initialize();
        return client.fold((ok) => ok, (e) {
          throw Exception('Error initializing Supabase. $e');
        });
      },
    );

    registerSingleton(ApplicationServiceImpl(getDependency()));
    registerSingleton(TaleServiceImpl(getDependency()));
  }

  Store<AppState> createStore() {
    log('Creating store...');
    final store = Store<AppState>(
      actionObservers: [
        if (enableActionLog)
          if (kDebugMode) Log.printer(formatter: Log.verySimpleFormatter),
      ],
      initialState: AppState.initial(),
    );

    // registerSingleton(store);

    log("Application has loaded these states:\n${store.state}");

    return store;
  }
}
