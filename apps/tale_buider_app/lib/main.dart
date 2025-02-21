import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

import 'features/splash/page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appStore = const AppStore();

  appStore.registerSingleton(EnvKeysServiceImpl());

  await appStore.registerAsyncSingleton(
    () async {
      final supabase = SupabaseServiceImpl(appStore.getDependency());
      final client = await supabase.initialize();
      return client.fold((ok) => ok, (e) {
        throw Exception('Error initializing Supabase. $e');
      });
    },
  );

  runApp(AppStoreProvider(
    appStore: appStore.createStore(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return MaterialApp(
      title: 'Tale Builder',
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      home: const SplashPage(),
    );
  }
}
