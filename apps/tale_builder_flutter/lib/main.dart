import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_builder_flutter/features/splash/layout.dart';
import 'package:tale_builder_flutter/features/splash/view/splash_view.dart';
import 'package:tale_builder_flutter/features/splash/view_model/splash_view_model.dart';
import 'package:tale_builder_flutter/features/tale/layout.dart';
import 'package:tale_builder_flutter/features/tale/repository/tale_repository.dart';
import 'package:tale_builder_flutter/features/tale/view/tale_view.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';
import 'package:tale_builder_flutter/store/app_store.dart';
import 'package:tale_builder_flutter/supabase/supabase_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabaseRepository = await SupabaseRepository.initialize(
    "http://127.0.0.1:54321", //todo:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  );

  final appStore = AppStore();
  final config = CoreAppConfig(
    root: _root,
    appStore: appStore,
    theme: UITheme(theme: (context) => AppTheme(borderRadius: 6)),
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
  initialLocation: "/tale/11111111-1111-1111-1111-111111111111",
  layouts: [
    UILayout(
      layoutBuilder: (context, state, shell) => SplashLayout(shell: shell),
      pages: [
        [
          UIPage(
            name: 'splash',
            path: "/",
            vm: (context, state) => SplashViewModel(),
            builder:
                (context, state, vm) => SplashView(vm: vm as SplashViewModel),
          ),
        ],
      ],
    ),
    UILayout(
      layoutBuilder: (context, state, shell) => TaleLayout(shell: shell),
      pages: [
        [
          UIPage(
            path: "/tale",
            redirect: (context, state) => '/tale/${state.pathParameters['id']}',
            pages: [
              UIPage(
                path: ":id",
                vm:
                    (context, state) => TaleViewModel(
                      context.readDependency<TaleRepository>(),
                      id: state.pathParameters['id']!,
                    ),
                builder:
                    (context, state, vm) => TaleView(vm: vm as TaleViewModel),
                pages: [],
              ),
            ],
          ),
        ],
      ],
    ),
  ],
);
