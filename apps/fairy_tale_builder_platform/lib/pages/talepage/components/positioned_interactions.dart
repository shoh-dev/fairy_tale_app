import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/components/interaction_object.dart';
import 'package:fairy_tale_builder_platform/components/page_background.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepagePositionedInteractions extends StatefulWidget {
  const TalepagePositionedInteractions({super.key});

  @override
  State<TalepagePositionedInteractions> createState() =>
      _TalepagePositionedInteractionsState();
}

class _TalepagePositionedInteractionsState
    extends State<TalepagePositionedInteractions>
    with
        StateConnectorMixinState<TalepagePositionedInteractions,
            (Tale, TalePage?, List<TaleInteraction>)> {
  @override
  Widget builder(BuildContext context, Dispatcher<AppState> dispatch,
      (Tale, TalePage?, List<TaleInteraction>) model) {
    final tale = model.$1;
    final page = model.$2;
    final interactions = model.$3;

    final device = Sizes.device;

    return Container(
      width: device.screenSize.height,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: DeviceFrame(
        orientation:
            tale.isPortrait ? Orientation.portrait : Orientation.landscape,
        device: device,
        screen: page == null
            ? Center(
                child: Text(
                  'No page selected',
                  style: context.textTheme.titleLarge,
                ),
              )
            : Stack(
                children: [
                  //image
                  Positioned.fill(
                    child: PageBackground(
                      url: page.metadata.backgroundImageUrl,
                      opacity: .3,
                    ),
                  ),

                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () => dispatch(ResetInteractionAction()),
                    ),
                  ),

                  for (final interaction in interactions)
                    InteractionObject(
                      interaction: interaction,
                      draggable: true,
                    ),
                ],
              ),
      ),
    );
  }

  @override
  (Tale, TalePage?, List<TaleInteraction>) selector(AppState state) {
    return (
      selectedTale(state),
      selectedPage(state),
      state.selectedTaleState.interactionsForPage,
    );
  }
}
