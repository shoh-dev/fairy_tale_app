import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_builder_flutter/features/splash/layout.dart';
import 'package:tale_builder_flutter/features/splash/view/splash_view.dart';
import 'package:tale_builder_flutter/features/splash/view_model/splash_view_model.dart';
import 'package:tale_builder_flutter/features/tale/layout.dart';
import 'package:tale_builder_flutter/features/tale/view/tale_view.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';
import 'package:tale_builder_flutter/store/app_store.dart';

void main() {
  UIRoot root(AppStore store) => UIRoot(
    initialLocation: "/tale/11111111-1111-1111-1111-111111111111",
    layouts: [
      // UILayout(
      //   layoutBuilder: (context, state, shell) => SplashLayout(shell: shell),
      //   pages: [
      //     [
      //       UIPage(
      //         name: 'splash',
      //         path: "/",
      //         vm: (context, state) => SplashViewModel(),
      //         builder:
      //             (context, state, vm) => SplashView(vm: vm as SplashViewModel),
      //       ),
      //     ],
      //   ],
      // ),
      UILayout(
        layoutBuilder: (context, state, shell) => TaleLayout(shell: shell),
        pages: [
          [
            UIPage(
              name: 'tale',
              path: "/tale",
              redirect:
                  (context, state) => '/tale/${state.pathParameters['id']}',
              pages: [
                UIPage(
                  path: ":id",
                  vm:
                      (context, state) =>
                          TaleViewModel(id: state.pathParameters['id']!),
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
  final appStore = AppStore();
  final config = CoreAppConfig(root: root, appStore: appStore);

  runMySpaceApp(config);
}
