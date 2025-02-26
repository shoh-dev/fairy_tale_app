import 'package:core_audio/core_audio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/splash/page.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //hide status bar
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final appStore = const AppStore();

  appStore.registerSingleton(EnvKeysServiceImpl());
  appStore.registerSingleton(PathServiceImpl());
  appStore.registerSingleton(const SystemServiceImpl());
  appStore.registerSingleton(MainAudioPlayerServiceImpl());
  appStore.registerSingleton(InteractionAudioPlayerServiceImpl());

  await appStore.registerAsyncSingleton(
    () async {
      final supabase = SupabaseServiceImpl(appStore.getDependency());
      final client = await supabase.initialize();
      return client.fold(
        (ok) => ok,
        (e) {
          throw Exception('Error initializing Supabase. $e');
        },
      );
    },
  );

  appStore.registerSingleton(ApplicationServiceImpl(appStore.getDependency()));
  appStore.registerSingleton(TaleServiceImpl(appStore.getDependency()));

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
      title: 'Flutter Demo',
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      home: const SplashPage(),
    );
  }
}
