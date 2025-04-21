import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_mobile_flutter/components/button.dart';
import 'package:tale_mobile_flutter/features/tale/view/components/body/my_tales_body.dart';
import 'package:tale_mobile_flutter/features/tale/view/components/search.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/my_tales_view_model.dart';
import 'package:tale_mobile_flutter/services/theme_service.dart';

class MyTalesView extends StatelessWidget {
  final MyTalesViewModel vm;

  static String route() => "/my_tales";

  const MyTalesView({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 12,
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                //Settings button
                AppIconButton(
                  onPressed: () {
                    final toggle = context.select<ThemeService, VoidCallback>(
                      (value) => value.toggleThemeMode,
                    );
                    toggle();
                  },
                  icon: Icons.settings_rounded,
                  bgColor: Colors.green,
                  fgColor: Colors.white,
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 12,
            right: 12,
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  //Settings button
                  AppIconButton(
                    icon: Icons.music_note_rounded,
                    bgColor: Colors.orange,
                    fgColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            left: 64,
            right: 64,
            child: CommandWrapper(
              command: vm.fetchMyTalesCommand,
              okBuilder: (context, _) => MyTalesBody(vm: vm),
            ),
          ),
          Positioned.fill(
            child: RepaintBoundary(
              child: Align(
                alignment: Alignment.topCenter,
                child: MyTalesSearch(onSearch: vm.onSearch),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
