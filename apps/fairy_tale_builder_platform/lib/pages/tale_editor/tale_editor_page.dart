import 'dart:developer';

import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/left_sidebar.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/page_details_form.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/right_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TaleEditorPage extends StatelessWidget {
  const TaleEditorPage({
    super.key,
    this.taleId = '',
  });

  final String taleId;

  @override
  Widget build(BuildContext context) {
    return StateResultConnector<AppState>(
      selector: (state) => state.taleListState.taleState.selectedTaleResult,
      onInitialBuild: (dispatch, model) {
        dispatch(GetTaleAction(taleId: taleId));
      },
      onDispose: (dispatch) {
        dispatch(SelectEditorTalePageAction(null));
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
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout();

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: const Text('Tale Editor'),
      leftSidebar: const TaleEditorLeftSidebarComponent(),
      rigthSidebar: const TaleEditorRightSidebarComponent(),
      leading: StateConnector<AppState, (bool, bool)>(
        selector: (state) => (
          state.taleListState.taleState.isTaleEdited,
          state.taleListState.taleState.editorState.isTalePageEdited
        ),
        builder: (context, dispatch, isEdited) {
          return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              void close() {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              }

              if (isEdited.$1 || isEdited.$2) {
                if (isEdited.$1) {
                  log('Tale is edited');
                }
                if (isEdited.$2) {
                  log('Tale page is edited');
                }
                close();
                return;
                //prompt user to save changes
              } else {
                close();
              }
            },
          );
        },
      ),
      actions: [
        DispatchConnector<AppState>(
          builder: (context, dispatch) {
            return ButtonComponent.icon(
              icon: Icons.save_rounded,
              onPressed: () {
                dispatch(SaveSelectedTaleAction());
              },
            );
          },
        ),
        const SizedBox(width: 8),
      ],
      body: StateConnector<AppState, bool>(
        selector: (state) => state
            .taleListState.taleState.editorState.selectedTalePage.id.isNotEmpty,
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
      ),
    );
  }
}
