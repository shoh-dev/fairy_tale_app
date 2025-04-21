import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_builder_flutter/features/splash/layout.dart';
import 'package:tale_builder_flutter/features/splash/view/splash_view.dart';
import 'package:tale_builder_flutter/features/splash/view_model/splash_view_model.dart';
import 'package:tale_builder_flutter/features/tale/layout.dart';
import 'package:tale_builder_flutter/features/tale/repository/localization_repository.dart';
import 'package:tale_builder_flutter/features/tale/repository/objects_repository.dart';
import 'package:tale_builder_flutter/features/tale/repository/pages_repository.dart';
import 'package:tale_builder_flutter/features/tale/repository/tale_repository.dart';
import 'package:tale_builder_flutter/features/tale/repository/texts_repository.dart';
import 'package:tale_builder_flutter/features/tale/view/tale_view.dart';
import 'package:tale_builder_flutter/features/tale/view/translations_view.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';
import 'package:tale_builder_flutter/features/tale/view_model/translations_view_model.dart';
import 'package:tale_builder_flutter/repository/file_picker_repository.dart';
import 'package:tale_builder_flutter/store/app_store.dart';
import 'package:tale_builder_flutter/supabase/supabase_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugRepaintRainbowEnabled = false;

  final supabaseRepository = await SupabaseRepository.initialize(
    "http://127.0.0.1:54321", //todo:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0',
  );

  final appStore = AppStore();
  final config = CoreAppConfig(
    root: _root,
    appStore: appStore,
    theme: UITheme(theme: (context) => AppTheme(borderRadius: 16)),
    dependencies: [
      Provider<SupabaseRepository>.value(value: supabaseRepository),
      Provider<TaleRepository>(
        create:
            (context) =>
                TaleRepository(context.read<SupabaseRepository>().client),
      ),
      Provider<TaleLocalizationRepository>(
        create:
            (context) => TaleLocalizationRepository(
              context.read<SupabaseRepository>().client,
            ),
      ),
      Provider<TalePagesRepository>(
        create:
            (context) =>
                TalePagesRepository(context.read<SupabaseRepository>().client),
      ),
      Provider<TalePageTextsRepository>(
        create:
            (context) => TalePageTextsRepository(
              context.read<SupabaseRepository>().client,
            ),
      ),
      Provider<TaleObjectsRepository>(
        create:
            (context) => TaleObjectsRepository(
              context.read<SupabaseRepository>().client,
            ),
      ),
      Provider<FilePickerRepository>(
        create: (context) => FilePickerRepository(),
      ),
    ],
  );

  runMySpaceApp(config);
}

UIRoot _root(AppStore store) => UIRoot(
  layouts: [
    UILayout(
      layoutBuilder: (context, state, shell) => SplashLayout(shell: shell),
      branches: [
        UIBranch(
          pages: [
            UIPage(
              name: 'splash',
              path: "/",
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => SplashViewModel(),
                    builder: (context, _) => SplashView(vm: context.read()),
                  ),
            ),
          ],
        ),
      ],
    ),
    UILayout(
      layoutBuilder: (context, state, shell) => TaleLayout(shell: shell),
      branches: [
        UIBranch(
          pages: [
            UIPage(
              path: "/tale",
              redirect: (context, state) {
                final id = state.pathParameters['id'];
                if (id == null) {
                  return TaleView.route(id);
                }

                if (state.fullPath.toString().endsWith("/translations")) {
                  return TranslationsView.route(id);
                }

                return TaleView.route(id);
              },
              pages: [
                UIPage(
                  path: ":id",
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create:
                            (context) => TaleViewModel(
                              id: state.pathParameters['id']!,
                              taleRepository: context.read(),
                              filePickerRepository: context.read(),
                              pageRepository: context.read(),
                              textsRepository: context.read(),
                            ),
                        builder: (context, _) => TaleView(vm: context.read()),
                      ),
                  pages: [
                    UIPage(
                      path: "/translations",

                      builder:
                          (context, state) => ChangeNotifierProvider(
                            create:
                                (context) => TranslationsViewModel(
                                  id: state.pathParameters['id']!,
                                  localizationRepository: context.read(),
                                ),
                            builder: (context, _) {
                              return TranslationsView(vm: context.read());
                            },
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
