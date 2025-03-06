import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:shared/shared.dart';

class LocalizationSettingsPage extends StatelessWidget {
  const LocalizationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: Text('Localization settings'),
      body: _Body(),
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
        selector: selectedTaleSelector,
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
          final localization =
              state.taleListState.taleState.selectedTale.localizations;
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
      child: Text('No Rows'),
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
                      onChanged: (value) {
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
                      stateManager.insertRows(0, stateManager.getNewRows());
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
                        SaveSelectedTaleLocalizationAction(
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
}
