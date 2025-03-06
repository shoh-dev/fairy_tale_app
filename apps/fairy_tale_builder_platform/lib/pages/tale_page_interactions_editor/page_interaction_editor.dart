import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/pages/tale_page_interactions_editor/components/interaction_object.dart';
import 'package:fairy_tale_builder_platform/pages/tale_page_interactions_editor/components/left_sidebar.dart';
import 'package:fairy_tale_builder_platform/pages/tale_page_interactions_editor/components/right_sidebar.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class TalePageInteractionsEditor extends StatelessWidget {
  const TalePageInteractionsEditor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: Text('Interactions Editor'),
      leftSidebar: InteractionLeftSidebarComponent(),
      rigthSidebar: InteractionRightSidebarComponent(),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: selectedTaleSelector,
      // onDispose: (dispatch) {
      // dispatch(SelectEditorTalePageInteractionAction([]));
      // },
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
                      child: Image.network(
                        page.metadata.backgroundImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),

                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        // context.dispatch(
                        //     SelectEditorTalePageInteractionAction([]));
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
