// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';

// class AppStore {
//   const AppStore({
//     this.enableActionLog = true,
//   });

//   final bool enableActionLog;

//   void registerSingleton<T extends Object>(T di, {bool unregisterIfExists = false}) {
//     DependencyInjection.registerSingleton<T>(di, deregisterIfExists: unregisterIfExists);
//   }

//   Future<void> registerAsyncSingleton<T extends Object>(FactoryFuncAsync<T> di, {bool unregisterIfExists = false}) {
//     DependencyInjection.registerAsyncSingleton<T>(di, deregisterIfExists: unregisterIfExists);
//     return allReady();
//   }

//   Future<void> allReady() {
//     return DependencyInjection.allReady();
//   }

//   T getDependency<T extends Object>() {
//     return DependencyInjection.get<T>();
//   }

//   Store<AppState> createStore() {
//     log('Creating store...');
//     final store = Store<AppState>(
//       actionObservers: [
//         // if (enableActionLog)
//         // if (kDebugMode) Log.printer(formatter: Log.verySimpleFormatter),
//       ],
//       initialState: AppState.initial(),
//     );

//     // registerSingleton(store);

//     log("Application has loaded these states:\n${store.state}");

//     return store;
//   }
// }
