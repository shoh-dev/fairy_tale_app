import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile/features/splash/page.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DependencyInjection di = DependencyInjection();

  FlutterError.onError = (details) {
    log(details.exception.toString());
    FlutterError.presentError(details);
  };

  final diResult = await di.init();

  diResult.when(
    ok: (_) {
      di.log.debug("DI initialized successfully!");
      runApp(AppStoreProvider(
        appStore: AppStore(di: di).createStore(),
        child: const MyApp(),
      ));
    },
    error: (error) {
      di.log.error(error);
      throw error;
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      home: const SplashPage(),
      builder: (context, child) {
        Widget error = const Text('...rendering error...');
        if (child is Scaffold || child is Navigator) {
          error = Scaffold(body: Center(child: error));
        }
        return child!;
      },
    );
  }
}
