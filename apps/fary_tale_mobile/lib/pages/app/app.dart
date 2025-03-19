import 'package:fairy_tale_mobile/pages/tale_list/tale_list_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme(
      seedDark: Colors.blueAccent,
      borderRadius: 8,
      surfaceDark: Colors.blueAccent,
    );

    return DispatchConnector<AppState>(
      onDispose: (dispatch) {
        context.getDependency<DependencyInjection>().dispose();
      },
      builder: (context, dispatch) => MaterialApp(
        title: 'Fairytale App',
        themeMode: ThemeMode.dark,
        theme: appTheme.lightTheme,
        darkTheme: appTheme.darkTheme,
        home: const TaleListPage(),
      ),
    );
  }
}
