import 'dart:developer';

import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/actions/tale_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/localization_settings/localization_settings_page.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/left_sidebar.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/page_details_form.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/right_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TaleEditorPage extends StatelessWidget {
  const TaleEditorPage({
    super.key,
    this.taleId = '',
  });

  final String taleId;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: const Text('Tale Editor'),
      leftSidebar: const TaleEditorLeftSidebarComponent(),
      rigthSidebar: const TaleEditorRightSidebarComponent(),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          void close() {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }

          // if (isEdited.$1 || isEdited.$2) {
          //   if (isEdited.$1) {
          //     log('Tale is edited');
          //   }
          //   if (isEdited.$2) {
          //     log('Tale page is edited');
          //   }
          //   close();
          //   return;
          //   //prompt user to save changes
          // } else {
          //   close();
          // }
          close();
        },
      ),
      actions: [
        StateConnector<AppState, Tale>(
          selector: selectedTale,
          builder: (context, dispatch, tale) {
            return ButtonComponent.iconDesctructive(
              tooltip: 'Delete Tale',
              icon: Icons.delete_rounded,
              onPressed: tale.isNew
                  ? null
                  : () {
                      //todo: add prompt dialog
                      dispatch(DeleteTaleAction());
                    },
            );
          },
        ),
        const SizedBox(width: 8),
        ButtonComponent.iconOutlined(
          icon: Icons.language_rounded,
          tooltip: 'Localization Editor',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const LocalizationSettingsPage(),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        StateConnector<AppState, ModelValidation>(
          selector: (state) => {}, //todo:
          // state.selectedTaleState.tale.isTaleValidToSave,
          builder: (context, dispatch, model) {
            return ButtonComponent.icon(
              icon: Icons.save_rounded,
              onPressed: () {
                if (model.isEmpty) {
                  dispatch(SaveTaleAction());
                  return;
                }
                log('TaleEditorPage.save: $model');
              },
            );
          },
        ),
        const SizedBox(width: 8),
      ],
      body: StateResultConnector<AppState>(
        selector: (state) => state.selectedTaleState.taleResult,
        onInitialBuild: (dispatch, model) {
          dispatch(GetTaleAction(taleId: taleId));
        },
        onDispose: (dispatch) {
          // dispatch(ResetTaleStateAction());//todo:
        },
        builder: (context, dispatch, model) {
          return model.when(
            ok: () {
              return const _Layout();
            },
            error: (error) {
              return Scaffold(
                body: Center(
                  child: Text(error.toString()),
                ),
              );
            },
            loading: () {
              return const Scaffold(
                body: LoadingComponent(),
              );
            },
            initial: () {
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, bool>(
      selector: isPageSelected,
      builder: (context, dispatch, isSelected) {
        if (isSelected) {
          //show page editor details
          return const TalePageDetailsForm();
        }
        return Center(
          child: Text(
            'Select a page to edit',
            style: context.textTheme.titleLarge,
          ),
        );
      },
    );
  }
}
