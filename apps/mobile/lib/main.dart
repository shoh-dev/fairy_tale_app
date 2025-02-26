import 'package:flutter/material.dart';
import 'package:mobile/features/splash/page.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DependencyInjection di = DependencyInjection();

  final diResult = await di.init();

  diResult.when(
    ok: (_) {
      runApp(AppStoreProvider(
        appStore: AppStore(di: di).createStore(),
        child: const MyApp(),
      ));
    },
    error: (error) => throw error,
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
    );
  }
}
