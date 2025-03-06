import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
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
      leading: StateConnector<AppState, bool>(
        selector: (state) =>
            state.taleListState.taleState.editorState.isInteractionEdited,
        builder: (context, dispatch, model) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              ButtonComponent.icon(
                icon: Icons.arrow_back_rounded,
                onPressed: model
                    ? null
                    : () {
                        //todo: prompt to save before quitting
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
              ),
              ButtonComponent.icon(
                icon: Icons.save_rounded,
                tooltip: 'Save',
                onPressed: !model
                    ? null
                    : () {
                        dispatch(SaveInteractionsAction());
                      },
              ),
              const ButtonComponent.iconDesctructive(
                icon: Icons.restore_rounded,
                tooltip: 'Reset',
              ),
            ],
          );
        },
      ),
      body: const _Body(),
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
        dispatch(SelectInteractionAction(null));
      },
      builder: (context, dispatch, tale) {
        return StateConnector<AppState, TalePage>(
          selector: selectedTalePageSelector,
          builder: (context, dispatch, page) {
            return DeviceFrame(
              device: Devices.ios.iPhone13,
              orientation: tale.isPortrait
                  ? Orientation.portrait
                  : Orientation.landscape,
              screen: Stack(
                children: [
                  //image
                  if (page.metadata.hasBackgroundImage)
                    Positioned.fill(
                      child: Opacity(
                        opacity: .3,
                        child: Image.network(
                          page.metadata.backgroundImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        dispatch(SelectInteractionAction(null));
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
