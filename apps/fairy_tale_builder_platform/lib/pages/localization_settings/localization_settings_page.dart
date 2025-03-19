import 'dart:developer';

import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:shared/shared.dart';

class LocalizationSettingsPage extends StatelessWidget {
  const LocalizationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: const Text('Localization settings'),
      leading: StateConnector<AppState, ModelValidation>(
        selector: (state) => state.selectedTaleState.tale.localizations.isValid,
        builder: (context, dispatch, model) {
          return ButtonComponent.icon(
            icon: Icons.arrow_back,
            onPressed: () {
              if (model.isEmpty) {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              } else {
                log('LocalizationSettingsPage: $model');
              }
            },
          );
        },
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final ValueNotifier<String> leftLocale = ValueNotifier('en');
  final ValueNotifier<String> rightLocale = ValueNotifier('en');

  @override
  Widget build(BuildContext context) {
    return PlutoGrid(
      noRowsWidget: noRowsWidget(),
      configuration: configurations(),
      columns: columns(),
      createHeader: (stateManager) => StateConnector<AppState, Tale>(
        selector: selectedTale,
        onInitialBuild: (dispatch, model) {
          final translations = <String, String>{
            for (final entry
                in model.localizations.translations[leftLocale.value]!.entries)
              entry.key: entry.value,
          };
          stateManager.appendRows([
            for (final entry in translations.entries) fromEntry(entry),
          ]);
        },
        onDidChange: (dispatch, state, model) {
          final localization = model.localizations;
          stateManager
            ..removeAllRows()
            ..appendRows([
              for (final entry
                  in localization.translations[leftLocale.value]?.entries ??
                      <MapEntry<String, String>>[])
                fromEntry(entry),
            ]);
        },
        builder: (context, dispatch, state) {
          return header(
            stateManager,
            localeNotifier: leftLocale,
            localization: state.localizations,
            onLocaleChanged: (value) {
              leftLocale.value = value;
            },
          );
        },
      ),
      onLoaded: (event) => onLoaded(event.stateManager),
      createFooter: PlutoPagination.new,
      rows: List.empty(growable: true),
    );
    // return PlutoDualGrid(
    //   gridPropsA: PlutoDualGridProps(
    //     noRowsWidget: noRowsWidget(),
    //     configuration: configurations(),
    //     columns: columns(),
    //     createHeader: (stateManager) => StateConnector<AppState, Tale>(
    //       selector: selectedTaleSelector,
    //       onInitialBuild: (dispatch, model) {
    //         final translations = <String, String>{
    //           if (model.localizations != null)
    //             for (final entry in model
    //                 .localizations!.translations[leftLocale.value]!.entries)
    //               entry.key: entry.value,
    //         };
    //         stateManager.appendRows([
    //           for (final entry in translations.entries) fromEntry(entry),
    //         ]);
    //       },
    //       onDidChange: (dispatch, state, model) {
    //         final localization =
    //             state.taleListState.taleState.selectedTale.localizations;
    //         stateManager
    //           ..removeAllRows()
    //           ..appendRows([
    //             for (final entry
    //                 in localization?.translations[leftLocale.value]?.entries
    // ??
    //                     <MapEntry<String, String>>[])
    //               fromEntry(entry),
    //           ]);
    //       },
    //       builder: (context, dispatch, state) {
    //         return header(
    //           stateManager,
    //           localeNotifier: leftLocale,
    //           localization: state.localizations,
    //           onLocaleChanged: (value) {
    //             leftLocale.value = value;
    //           },
    //         );
    //       },
    //     ),
    //     onLoaded: (event) => onLoaded(event.stateManager),
    //     createFooter: PlutoPagination.new,
    //     rows: [],
    //   ),
    //   gridPropsB: PlutoDualGridProps(
    //     noRowsWidget: noRowsWidget(),
    //     configuration: configurations(),
    //     columns: columns(),
    //     createHeader: (stateManager) => StateConnector<AppState, Tale>(
    //       selector: selectedTaleSelector,
    //       onDidChange: (dispatch, state, model) {
    //         stateManager
    //           ..removeAllRows()
    //           ..appendRows([
    //             // for (final entry in model.translations.entries)
    //             // fromEntry(entry),
    //           ]);
    //       },
    //       onInitialBuild: (dispatch, model) {
    //         // stateManager.appendRows([
    //         //   for (final entry in model.translations.entries) fromEntry(entry),
    //         // ]);
    //         // if (model.status.isOk) {
    //         //   return;
    //         // }
    //         // dispatch(
    //         //   GetTranslationsAction(
    //         //     for2: true,
    //         //     newLocale: 'ru',
    //         //   ),
    //         // );
    //       },
    //       builder: (context, dispatch, state) {
    //         return const SizedBox();
    //         // return header(
    //         //   stateManager,
    //         //   locale: state.locale,
    //         //   translations: state.translations,
    //         //   version: state.localeVersion,
    //         //   isLoading: state.status.isLoading,
    //         //   for2: true,
    //         // );
    //       },
    //     ),
    //     onLoaded: (event) => onLoaded(event.stateManager),
    //     createFooter: PlutoPagination.new,
    //     rows: [],
    //     // rowColorCallback: rowColorCallback,
    //   ),
    // );
  }

  Color rowColorCallback(PlutoRowColorContext ctx) {
    if (ctx.row.state.isAdded) {
      return Colors.green;
    }
    if (ctx.row.state.isUpdated) {
      return Colors.blueAccent;
    }
    return const PlutoGridStyleConfig.dark().rowColor;
  }

  Widget noRowsWidget() {
    return const Center(
      child: Text('No translations'),
    );
  }

  PlutoGridConfiguration configurations() {
    return const PlutoGridConfiguration.dark(
      columnSize: PlutoGridColumnSizeConfig(
        autoSizeMode: PlutoAutoSizeMode.scale,
      ),
    );
  }

  List<PlutoColumn> columns() {
    return [
      PlutoColumn(
        title: 'Key',
        field: 'key',
        type: PlutoColumnType.text(),
        enableAutoEditing: true,
        enableContextMenu: false,
        enableColumnDrag: false,
        enableDropToResize: false,
        width: 100,
        backgroundColor: Colors.blueGrey,
      ),
      PlutoColumn(
        title: 'Value',
        field: 'value',
        type: PlutoColumnType.text(),
        enableAutoEditing: true,
        enableContextMenu: false,
        enableColumnDrag: false,
        enableDropToResize: false,
        backgroundColor: Colors.blueGrey,
      ),
      PlutoColumn(
        title: '',
        field: 'delete',
        type: PlutoColumnType.text(),
        enableContextMenu: false,
        enableColumnDrag: false,
        enableDropToResize: false,
        enableFilterMenuItem: false,
        enableSorting: false,
        enableEditingMode: false,
        backgroundColor: Colors.blueGrey,
        width: 30,
        renderer: (rendererContext) {
          return ButtonComponent.iconDesctructive(
            icon: Icons.delete_rounded,
            onPressed: () {
              rendererContext.stateManager.removeRows([rendererContext.row]);
            },
          );
        },
      ),
    ];
  }

  PlutoRow<MapEntry<String, String>> fromEntry(MapEntry<String, String> entry) {
    return PlutoRow<MapEntry<String, String>>(
      cells: {
        'key': PlutoCell(value: entry.key),
        'value': PlutoCell(value: entry.value),
        'delete': PlutoCell(value: entry),
      },
    );
  }

  void onLoaded(PlutoGridStateManager stateManager) {
    stateManager
      ..setPageSize(20)
      ..setShowColumnFilter(true);
  }

  Widget header(
    PlutoGridStateManager stateManager, {
    required ValueNotifier<String> localeNotifier,
    required TaleLocalization? localization,
    required ValueChanged<String> onLocaleChanged,
  }) {
    return SizedBox(
      height: kToolbarHeight,
      child: DispatchConnector<AppState>(
        builder: (context, dispatch) {
          return ValueListenableBuilder(
            valueListenable: localeNotifier,
            builder: (context, locale, _) {
              final locales = localization?.translations.keys;
              if (locales?.isEmpty ?? true) {
                return const SizedBox.shrink();
              }
              return Row(
                children: [
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 200,
                    child: DropdownComponent<String>(
                      // hintText: locale,
                      initialValue: DropdownItem(value: locale, label: locale),
                      onChanged: (value, controller) async {
                        if (value?.value == 'add') {
                          final newLocale = await _showAddLocaleDialog(context);
                          if (newLocale != null) {
                            final rows = stateManager.rows;
                            final keys = rows.map<String>(
                              (e) =>
                                  "${newLocale.toUpperCase()}_${e.cells['key']!.value}",
                            );
                            final values = rows.map<String>(
                              (e) =>
                                  '${newLocale.toUpperCase()} ${e.cells['value']!.value}',
                            );
                            onLocaleChanged(newLocale);
                            dispatch(
                              UpdateTaleTranslationsAction(
                                locale: newLocale,
                                keys: keys,
                                values: values,
                              ),
                            );
                          }
                          return;
                        }
                        if (value == null || value.value == locale) {
                          return;
                        }
                        stateManager
                          ..removeAllRows()
                          ..appendRows([
                            for (final entry in localization
                                    ?.translations[value.value]?.entries ??
                                <MapEntry<String, String>>[])
                              fromEntry(entry),
                          ]);
                        onLocaleChanged(value.value);
                      },
                      items: [
                        DropdownItem(
                          value: 'add',
                          label: 'Add locale',
                          icon: Icons.add_rounded,
                        ),
                        for (final l in locales ?? <String>[])
                          DropdownItem(
                            value: l,
                            label: l,
                          ),
                      ],
                    ),
                  ),
                  const Spacer(),

                  ButtonComponent.iconDesctructive(
                    tooltip: 'Restore default',
                    icon: Icons.restore_rounded,
                    onPressed: () {
                      stateManager
                        ..removeAllRows()
                        ..appendRows([
                          for (final entry
                              in localization?.translations[locale]?.entries ??
                                  <MapEntry<String, String>>[])
                            fromEntry(entry),
                        ]);
                    },
                  ),

                  const SizedBox(width: 8),
                  //Add button
                  ButtonComponent.icon(
                    tooltip: 'Add',
                    icon: Icons.add_rounded,
                    onPressed: () {
                      stateManager.insertRows(0, [
                        fromEntry(
                          MapEntry('key_${stateManager.rows.length}', 'value'),
                        ),
                      ]);
                    },
                  ),
                  const SizedBox(width: 8),
                  ButtonComponent.icon(
                    tooltip: 'Save',
                    icon: Icons.save_rounded,
                    onPressed: () {
                      final rows = stateManager.rows;
                      final keys = rows
                          .map<String>((e) => e.cells['key']!.value.toString());
                      final values = rows.map<String>(
                        (e) => e.cells['value']!.value.toString(),
                      );
                      dispatch(
                        UpdateTaleTranslationsAction(
                          locale: locale,
                          keys: keys,
                          values: values,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<String?> _showAddLocaleDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) => const _AddLocaleDialog(),
    );
  }
}

class _AddLocaleDialog extends StatefulWidget {
  const _AddLocaleDialog();

  @override
  State<_AddLocaleDialog> createState() => __AddLocaleDialogState();
}

class __AddLocaleDialogState extends State<_AddLocaleDialog> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add locale'),
      titleTextStyle: context.textTheme.titleMedium,
      content: TextFieldComponent(
        autoFocus: true,
        controller: controller,
        hintText: 'en, ru, uz, etc.',
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ButtonComponent.outlined(
          text: 'Cancel',
          icon: Icons.cancel_rounded,
          onPressed: () => Navigator.pop(context),
        ),
        ButtonComponent.primary(
          text: 'Save',
          icon: Icons.save_rounded,
          onPressed: () {
            if (controller.text.isEmpty) {
              return;
            }
            Navigator.pop(context, controller.text.toLowerCase().trim());
          },
        ),
      ],
    );
  }
}
