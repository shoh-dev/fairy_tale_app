import 'package:flutter/material.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_mobile_flutter/components/button.dart';

class SettingsView extends StatelessWidget {
  static const String path = "/settings";

  const SettingsView({super.key});

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
                AppIconButton(onPressed: context.pop, icon: Icons.arrow_back),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
