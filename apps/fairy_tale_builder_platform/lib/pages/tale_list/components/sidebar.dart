import 'package:fairy_tale_builder_platform/pages/localization_settings/localization_settings_page.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/tale_editor_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TaleListSidebarComponent extends StatelessWidget {
  const TaleListSidebarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: context.height,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...ListTile.divideTiles(
                context: context,
                tiles: [
                  //create new tale
                  ListTile(
                    leading: const Icon(Icons.add_rounded),
                    title: const Text('Create new tale'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => const TaleEditorPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.language_rounded),
                    title: const Text('Localization settings'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              const LocalizationSettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          //footer
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...ListTile.divideTiles(
                context: context,
                tiles: [],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
