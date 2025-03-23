import 'package:fairy_tale_builder_platform/pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

final _router = GoRouter(
  navigatorKey: NavigateAction.navigatorKey,
  routes: $appRoutes,
  debugLogDiagnostics: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final log = Log();

  final di = DependencyInjection();

  final diResult = await di.init();

  diResult.when(
    ok: (_) {
      log.debug('DI initialized successfully!');
      runApp(
        StoreProvider(
          appStore: AppStore(
            enableActionLog: true,
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
    final appTheme = AppTheme(
      borderRadius: 4,
      surfaceDark: Colors.black,
      seedDark: const Color(0xFF8B5CF6),
    );
    //     // Base Colors
    // Black: #000000
    // Dark Gray (Background): #121212
    // Dark Gray (Surface): #1E1E1E
    // Dark Gray (Cards): #242424
    // Zinc-800: #27272A
    // Zinc-900: #18181B

    // // Accent Colors
    // Purple-500: #8B5CF6
    // Purple-600: #7C3AED
    // Purple-700: #6D28D9
    // Pink-500: #EC4899
    // Pink-600: #DB2777

    // // Text Colors
    // White: #FFFFFF
    // Gray-200: #E5E7EB
    // Gray-400: #9CA3AF
    // Zinc-400: #A1A1AA
    // Zinc-500: #71717A

    //new design
    return MaterialApp.router(
      title: 'Tale Builder',
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );

    // //old design
    // return MaterialApp(
    //   title: 'Tale Builder',
    //   theme: appTheme.lightTheme,
    //   darkTheme: appTheme.darkTheme,
    //   debugShowCheckedModeBanner: false,
    //   navigatorKey: NavigateAction.navigatorKey,
    //   home: const SplashPage(),
    // );
  }
}
