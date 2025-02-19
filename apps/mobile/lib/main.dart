import 'package:flutter/material.dart';
import 'package:mobile/features/splash/page.dart';
// import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //hide status bar
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // SystemChrome.setPreferredOrientations([
  // DeviceOrientation.landscapeLeft,
  // DeviceOrientation.landscapeRight,
  // ]);

  final appStore = const AppStore();

  await appStore.setupDependencies();

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
