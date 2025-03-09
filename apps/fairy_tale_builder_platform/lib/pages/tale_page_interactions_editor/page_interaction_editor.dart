import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/components/orientation_selector.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/interaction_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/tale_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/tale_preview_dialog.dart';
import 'package:fairy_tale_builder_platform/pages/tale_page_interactions_editor/components/interaction_object.dart';
import 'package:fairy_tale_builder_platform/pages/tale_page_interactions_editor/components/left_sidebar.dart';
import 'package:fairy_tale_builder_platform/pages/tale_page_interactions_editor/components/right_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalePageInteractionsEditor extends StatelessWidget {
  const TalePageInteractionsEditor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: const Text('Interactions Editor'),
      leftSidebar: const InteractionLeftSidebarComponent(),
      rigthSidebar: const InteractionRightSidebarComponent(),
      actions: [
        StateConnector<AppState, ModelValidation>(
          selector: (state) =>
              state.taleListState.taleState.isInteractionsValidToSave,
          builder: (context, dispatch, model) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                StateConnector<AppState, Tale>(
                  selector: selectedTaleSelector,
                  builder: (context, dispatch, model) => SizedBox(
                    width: 200,
                    child: OrientationSelector(
                      hasLabel: false,
                      orientation: model.orientation,
                      onChanged: (value) {
                        dispatch(UpdateTaleAction(orientation: value));
                      },
                    ),
                  ),
                ),
                const ButtonComponent.iconDesctructive(
                  icon: Icons.restore_rounded,
                  tooltip: 'Reset',
                ),
                ButtonComponent.iconOutlined(
                  tooltip: 'Preview Page',
                  icon: Icons.remove_red_eye_rounded,
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) => StateConnector<AppState, TalePage?>(
                        selector: selectedTalePageSelector,
                        builder: (context, dispatch, model) => model == null
                            ? const SizedBox()
                            : //todo: check this
                            TalePreviewDialog(id: model.id),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 1),
              ],
            );
          },
        ),
      ],
      leading: StateConnector<AppState, ModelValidation>(
        selector: (state) =>
            state.taleListState.taleState.isInteractionsValidToSave,
        builder: (context, dispatch, model) {
          return ButtonComponent.icon(
            icon: Icons.arrow_back_rounded,
            onPressed: () {
              if (model.isNotEmpty) {
                log('TalePageInteractionsEditor: $model');
                return;
              }
              //todo: prompt to save before quitting
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          );
        },
      ),
      body: StateConnector<AppState, StateResult>(
        selector: (state) =>
            state.taleListState.taleState.editorState.interactionResult,
        builder: (context, _, result) {
          return result.when(
            ok: () => const _Body(),
            initial: () => const _Body(),
            loading: LoadingComponent.new,
            error: (e) => Center(child: Text(e.toString())),
          );
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: selectedTaleSelector,
      onDispose: (dispatch) {
        dispatch(ResetInteractinAction());
      },
      builder: (context, dispatch, tale) {
        return StateConnector<AppState, TalePage?>(
          selector: selectedTalePageSelector,
          builder: (context, dispatch, page) {
            if (page == null) {
              return const SizedBox();
            }
            return DeviceFrame(
              device: Devices.ios.iPhoneSE,
              orientation: tale.isPortrait
                  ? Orientation.portrait
                  : Orientation.landscape,
              screen: Stack(
                children: [
                  //image
                  if (page.metadata.hasBackgroundImage)
                    Positioned.fill(
                      child: Opacity(
                        opacity: .2,
                        child: Image.network(
                          '${page.metadata.backgroundImageUrl}?${DateTime.now().millisecondsSinceEpoch}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        dispatch(ResetInteractinAction());
                      },
                    ),
                  ),

                  for (final interaction in page.interactions)
                    //tale object
                    InteractionObjectComponent(interaction: interaction),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
