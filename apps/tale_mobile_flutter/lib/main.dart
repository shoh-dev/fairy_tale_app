import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_mobile_flutter/features/tale/layout.dart';
import 'package:tale_mobile_flutter/features/tale/repository/tale_repository.dart';
import 'package:tale_mobile_flutter/features/tale/view/my_tales_view.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/my_tales_view_model.dart';
import 'package:tale_mobile_flutter/store/app_store.dart';
import 'package:tale_mobile_flutter/supabase/supabase_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugRepaintRainbowEnabled = false;

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
  final config = CoreAppConfig(
    root: _root,
    appStore: appStore,
    theme: UITheme(
      theme: (context) => AppTheme(borderRadius: 16),
      themeMode: (context) => ThemeMode.dark,
    ),
    dependencies: [
      Provider<SupabaseRepository>.value(value: supabaseRepository),
      Provider<TaleRepository>(
        create:
            (context) => TaleRepository(
              context.readDependency<SupabaseRepository>().client,
            ),
      ),
    ],
  );

  runMySpaceApp(config);
}

UIRoot _root(AppStore store) => UIRoot(
  initialLocation: MyTalesView.route(),
  layouts: [
    UILayout(
      layoutBuilder: (context, state, shell) => MyTalesLayout(shell: shell),
      pages: [
        [
          UIPage(
            path: MyTalesView.route(),
            vm:
                (context, state) =>
                    MyTalesViewModel(taleRepository: context.readDependency()),
            builder:
                (context, state, vm) => MyTalesView(vm: vm as MyTalesViewModel),
          ),
        ],
      ],
    ),
  ],
);
