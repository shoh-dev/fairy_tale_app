import 'dart:developer';

import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/app/localization/state2.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

class LocalizationSettingsPage extends StatelessWidget {
  const LocalizationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: Text('Localization settings'),
      // rigthSidebar: const LocalizationSettingsRightSidebarComponent(),
      body: _Body(),
      //  StateConnector<AppState, (StateResult, StateResult)>(
      //   selector: (state) => (
      //     state.applicationState.localizationState.status,
      //     state.applicationState.localizationState2.status,
      //   ),
      //   onInitialBuild: (dispatch, model) {},
      //   builder: (context, dispatch, model) {
      //     if (model.$1.isOk && model.$2.isOk) {
      //       return const _Body();
      //     }
      //     if (model.$1.isLoading || model.$2.isLoading) {
      //       return const LoadingComponent();
      //     }
      //     if (model.$1.isError) {
      //       return const Center(
      //         child: Text('Failed to load localization 1'),
      //       );
      //     }
      //     if (model.$2.isError) {
      //       return const Center(
      //         child: Text('Failed to load localization 2'),
      //       );
      //     }
      //     return const SizedBox();
      //   },
      // ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return PlutoDualGrid(
      gridPropsA: PlutoDualGridProps(
        noRowsWidget: noRowsWidget(),
        configuration: configurations(),
        columns: columns(),
        createHeader: (stateManager) =>
            StateConnector<AppState, LocalizationState>(
          selector: (state) => state.applicationState.localizationState,
          onInitialBuild: (dispatch, model) {
            stateManager.appendRows([
              for (final entry in model.translations.entries) fromEntry(entry),
            ]);
            if (model.status.isOk) {
              return;
            }
            dispatch(GetTranslationsAction());
          },
          onDidChange: (dispatch, state, model) {
            stateManager
              ..removeAllRows()
              ..appendRows([
                for (final entry in model.translations.entries)
                  fromEntry(entry),
              ]);
          },
          builder: (context, dispatch, state) {
            return header(
              stateManager,
              locale: state.locale,
              translations: state.translations,
              version: state.localeVersion,
            );
          },
        ),
        onLoaded: (event) => onLoaded(event.stateManager),
        createFooter: PlutoPagination.new,
        rows: [],
      ),
      gridPropsB: PlutoDualGridProps(
        noRowsWidget: noRowsWidget(),
        configuration: configurations(),
        columns: columns(),
        createHeader: (stateManager) =>
            StateConnector<AppState, LocalizationState2>(
          selector: (state) => state.applicationState.localizationState2,
          onDidChange: (dispatch, state, model) {
            stateManager
              ..removeAllRows()
              ..appendRows([
                for (final entry in model.translations.entries)
                  fromEntry(entry),
              ]);
          },
          onInitialBuild: (dispatch, model) {
            stateManager.appendRows([
              for (final entry in model.translations.entries) fromEntry(entry),
            ]);
            if (model.status.isOk) {
              return;
            }
            dispatch(
              GetTranslationsAction(
                for2: true,
                newLocale: 'ru',
              ),
            );
          },
          builder: (context, dispatch, state) {
            return header(
              stateManager,
              locale: state.locale,
              translations: state.translations,
              version: state.localeVersion,
            );
          },
        ),
        onLoaded: (event) => onLoaded(event.stateManager),
        createFooter: PlutoPagination.new,
        rows: [],
      ),
    );
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
    required String locale,
    required int version,
    required Map<String, String> translations,
  }) {
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        children: [
          const SizedBox(width: 8),
          Text('$locale - $version'),
          const Spacer(),
          ButtonComponent.iconDesctructive(
            icon: Icons.restore_rounded,
            onPressed: () {
              stateManager
                ..removeAllRows()
                ..appendRows([
                  for (final entry in translations.entries) fromEntry(entry),
                ]);
            },
          ),
          const SizedBox(width: 8),
          //Add button
          ButtonComponent.icon(
            icon: Icons.add_rounded,
            onPressed: stateManager.appendNewRows,
          ),
          const SizedBox(width: 8),
          ButtonComponent.icon(
            icon: Icons.save_rounded,
            onPressed: () {
              final rows = stateManager.rows;
              log(rows.map((e) => e.cells['key']!.value).toString()); //todo:
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
