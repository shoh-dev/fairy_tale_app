import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_mobile_flutter/features/settings/layout.dart';
import 'package:tale_mobile_flutter/features/settings/view/settings_view.dart';
import 'package:tale_mobile_flutter/features/settings/vm/settings_view_model.dart';
import 'package:tale_mobile_flutter/features/tale/layout.dart';
import 'package:tale_mobile_flutter/features/tale/view/my_tales_view.dart';
import 'package:tale_mobile_flutter/features/tale/view/tale_view.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/my_tales_view_model.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/tale_view_model.dart';
import 'package:tale_mobile_flutter/repository/tale_repository.dart';
import 'package:tale_mobile_flutter/services/theme_service.dart';
import 'package:tale_mobile_flutter/store/app_store.dart';
import 'package:tale_mobile_flutter/supabase/supabase_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugRepaintRainbowEnabled = false;

  // await ScreenUtil.ensureScreenSize();

  await Future.wait([
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]),
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
  ]);

  final supabaseRepository = await SupabaseRepository.initialize(
    "http://127.0.0.1:54321", //todo:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  );

  final appStore = AppStore();

  //SE 375 x 667
  //XR 414 x 896
  //X, 11Pro 375 x 812
  //iPad Mini (6th gen) 744 x 1133
  //iPad mini a17 2266 x 1488
  // final size = const Size(744, 1133);
  // final size = const Size(736, 414);
  // final size = const Size(812, 375);
  //Size(390.0, 844.0)
  // final size = const Size(667.0, 375.0);
  final size = const Size(844, 390);

  final config = CoreAppConfig(
    root: _root,
    appStore: appStore,
    builder: (context, child) {
      log('Running builder');
      ScreenUtil.init(context, designSize: size);
      return child!;
    },
    theme: UITheme(
      theme: (context) {
        return AppTheme(
          borderRadius: 64,
          colorSchemeLight: ColorScheme.fromSeed(
            seedColor: Colors.lightBlue,
            dynamicSchemeVariant: DynamicSchemeVariant.rainbow,
            brightness: Brightness.light,
          ),
        );
      },
      themeMode:
          (context) =>
              context.select<ThemeService, ThemeMode>((value) => value.mode),
    ),
    dependencies: [
      Provider<SupabaseRepository>.value(value: supabaseRepository),
      Provider<TaleRepository>(
        create:
            (context) =>
                TaleRepository(context.read<SupabaseRepository>().client),
      ),
      ChangeNotifierProvider<ThemeService>(create: (context) => ThemeService()),
    ],
  );

  runMySpaceApp(config);
}

UIRoot _root(AppStore store) => UIRoot(
  initialLocation: MyTalesView.route(),
  layouts: [
    UILayout(
      layoutBuilder: (context, state, shell) => MyTalesLayout(shell: shell),
      branches: [
        UIBranch(
          pages: [
            UIPage(
              path: MyTalesView.route(),
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create:
                        (context) =>
                            MyTalesViewModel(taleRepository: context.read()),
                    builder: (context, child) {
                      return MyTalesView(vm: context.read());
                    },
                  ),
              pages: [
                UIPage(
                  path: ":id",
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInOutCirc,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create:
                            (context) => TaleViewModel(
                              state.pathParameters['id']!,
                              taleRepository: context.read(),
                            ),

                        builder: (context, _) {
                          return TaleView(vm: context.read());
                        },
                      ),
                ),
              ],
            ),
            UIPage(
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(
                  opacity: CurveTween(
                    curve: Curves.easeInOutCirc,
                  ).animate(animation),
                  child: child,
                );
              },
              path: SettingsView.path,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => SettingsViewModel(),
                    builder: (context, _) => SettingsView(),
                  ),
            ),
          ],
        ),
      ],
    ),

    UILayout(
      layoutBuilder: (context, state, shell) => MyTalesLayout(shell: shell),
      branches: [
        UIBranch(
          pages: [
            UIPage(
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return FadeTransition(
                  opacity: CurveTween(
                    curve: Curves.easeInOutCirc,
                  ).animate(animation),
                  child: child,
                );
              },
              path: SettingsView.path,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => SettingsViewModel(),
                    builder: (context, _) => SettingsView(),
                  ),
            ),
          ],
        ),
      ],
    ),
  ],
);
