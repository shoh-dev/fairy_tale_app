import 'package:fairy_tale_builder_platform/pages/splash/splash_page.dart';
import 'package:fairy_tale_builder_platform/manager/redux.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final log = Log();

  final di = DependencyInjection();

  FlutterError.onError = (details) {
    log.error(details.exception.toString());
    FlutterError.presentError(details);
  };

  final diResult = await di.init();

  diResult.when(
    ok: (_) {
      log.debug('DI initialized successfully!');
      runApp(
        StoreProvider(
          appStore: AppStore(
            initialState: AppState.initial(),
            di: di,
          ).createStore(),
          child: const App(),
        ),
      );
    },
    error: (error) {
      log.error(error);
      throw error;
    },
  );
}

class App extends StatelessWidget {
  const App({super.key});

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
