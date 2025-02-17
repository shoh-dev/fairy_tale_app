import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class DependencyInjection {
  static final _getIt = GetIt.instance;

  static void registerSingleton<T extends Object>(T di, {bool deregisterIfExists = false}) {
    if (_getIt.isRegistered<T>()) {
      if (deregisterIfExists) {
        _getIt.unregister<T>();
      } else {
        return;
      }
    }

    _getIt.registerSingleton<T>(di);

    log("Registered $T");
  }

  static void registerAsyncSingleton<T extends Object>(FactoryFuncAsync<T> di, {bool deregisterIfExists = false}) {
    if (_getIt.isRegistered<T>()) {
      if (deregisterIfExists) {
        _getIt.unregister<T>();
      } else {
        return;
      }
    }

    _getIt.registerSingletonAsync<T>(di);

    log("Registered $T");
  }

  static T get<T extends Object>() {
    return _getIt.get<T>();
  }

  static bool isRegistered<T extends Object>() {
    return _getIt.isRegistered<T>();
  }

  static void unregister<T extends Object>() {
    _getIt.unregister<T>();
  }

  static Future<void> allReady() {
    return _getIt.allReady();
  }
}

extension ContextHelperDi on BuildContext {
  T getDependency<T extends Object>() {
    return DependencyInjection.get<T>();
  }
}
