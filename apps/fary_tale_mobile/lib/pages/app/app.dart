import 'package:fairy_tale_mobile/manager/di/di.dart';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return DispatchConnector<AppState>(
      onDispose: (dispatch) {
        context.getDependency<DependencyInjection>().dispose();
      },
      builder: (context, dispatch) => MaterialApp(
        title: 'Fairytale App',
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
      ),
    );
  }
}
