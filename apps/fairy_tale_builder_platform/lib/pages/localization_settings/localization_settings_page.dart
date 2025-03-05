import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/app/localization/state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/localization_settings/components/right_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class LocalizationSettingsPage extends StatefulWidget {
  const LocalizationSettingsPage({super.key});

  @override
  State<LocalizationSettingsPage> createState() =>
      _LocalizationSettingsPageState();
}

class _LocalizationSettingsPageState extends State<LocalizationSettingsPage>
    with StateHelpers {
  final Map<TextEditingController, TextEditingController> translations = {};

  void disposeTr() {
    for (final controller in translations.keys) {
      controller.dispose();
    }
    translations.clear();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: const Text('Localization settings'),
      rigthSidebar: const LocalizationSettingsRightSidebarComponent(),
      body: StateResultConnector<AppState>(
        selector: (state) => state.applicationState.localizationState.status,
        onDispose: (dispatch) {
          safeDispose(disposeTr);
        },
        builder: (context, dispatch, model) {
          return model.when(
            ok: () {
              return _Body(
                translations: translations,
                onLoaded: (tr) {
                  disposeTr();
                  safeSetState(() {
                    translations.addAll(
                      tr.map(
                        (key, value) => MapEntry(
                          TextEditingController(text: key),
                          TextEditingController(text: value),
                        ),
                      ),
                    );
                  });
                },
              );
            },
            initial: () => const SizedBox(),
            loading: () => const LoadingComponent(),
            error: (error) => Center(child: Text(error.toString())),
          );
        },
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    required this.translations,
    required this.onLoaded,
  });

  final Map<TextEditingController, TextEditingController> translations;
  final ValueChanged<Map<String, String>> onLoaded;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with StateHelpers {
  Map<TextEditingController, TextEditingController> get translations =>
      widget.translations;

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, LocalizationState>(
      selector: (state) => state.applicationState.localizationState,
      onInitialBuild: (dispatch, model) {
        widget.onLoaded(model.translations);
      },
      builder: (context, dispatch, _) {
        return DataTable(
          border: TableBorder.all(
            color: Colors.grey,
          ),
          headingTextStyle: context.textTheme.titleMedium,
          columns: const [
            DataColumn(
              label: Text('Key'),
            ),
            DataColumn(
              label: Text('Value'),
            ),
          ],
          rows: [
            for (final entry in translations.entries)
              DataRow(
                cells: [
                  DataCell(
                    SizedBox(
                      width: 400,
                      child: TextField(controller: entry.key),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: 800,
                      child: TextField(controller: entry.value),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
