import 'package:core_tales/core_tales.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_redux/myspace_redux.dart';

import 'features/tales/page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appStore = const AppStore();

  final supabase = SupabaseServiceImpl();

  final client = await supabase.initialize(
    url: "http://127.0.0.1:54321",
    key:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0",
  );

  client.fold(
    (ok) => appStore.registerSingleton(ok),
    (_) {
      //todo: handle error
    },
  );

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
      home: const TalesPage(),
    );
  }
}
