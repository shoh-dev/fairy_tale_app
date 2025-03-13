import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/components/translator_component.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class Preview extends StatelessWidget
    with StateConnectorMixin<(Tale, TalePage?, List<TaleInteraction>)> {
  const Preview({super.key});

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    (Tale, TalePage?, List<TaleInteraction>) model,
  ) {
    final device = Devices.ios.iPhone13;
    final tale = model.$1;
    final page = model.$2;
    final interactions = model.$3;

    return DeviceFrame(
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
                  child: page.metadata.hasBackgroundImage
                      ? Image.network(
                          page.metadata.backgroundImageUrl,
                          fit: BoxFit.cover,
                        )
                      : Placeholder(
                          child: Center(
                            child: Text(
                              'No background image',
                              style: context.textTheme.titleLarge,
                            ),
                          ),
                        ),
                ),

                for (final interaction in interactions)
                  //tale object
                  Positioned(
                    width: interaction.size.width,
                    height: interaction.size.height,
                    left: interaction.currentPosition.dx,
                    top: interaction.currentPosition.dy,
                    child: Translator(
                      toTranslate: [interaction.hintKey],
                      builder: (translatedValue) {
                        return Tooltip(
                          triggerMode: TooltipTriggerMode.longPress,
                          message: translatedValue[0],
                          showDuration: const Duration(seconds: 5),
                          child: Container(
                            width: interaction.size.width,
                            height: interaction.size.height,
                            decoration: !interaction.metadata.hasImage
                                ? BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(100),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  )
                                : null,
                            child: interaction.metadata.hasImage
                                ? Image.network(interaction.metadata.imageUrl)
                                : const SizedBox(),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
    );
  }

  @override
  (Tale, TalePage?, List<TaleInteraction>) selector(AppState state) {
    return (
      selectedTale(state),
      selectedPage(state),
      interactionsForPage(state),
    );
  }

  static Future<void> dialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              const Text('Page Preview'),
              const Spacer(),
              ButtonComponent.iconOutlined(
                icon: Icons.close_rounded,
                onPressed: Navigator.of(context).pop,
              ),
            ],
          ),
          content: const Preview(),
        );
      },
    );
  }
}


// Stack(
//         children: [
//           //image
//           if (page.metadata.hasBackgroundImage)
//             Positioned.fill(
//               child: SelectedTalePageBackroundComponent(
//                 imageUrl: page.metadata.backgroundImageUrl,
//               ),
//             ),

//           for (final interaction in interactions)
//             //tale object
//             Builder(
//               builder: (context) {
//                 return AnimatedPositioned(
//                   // curve: Curves.ease, //todo: get curve from db
//                   duration: Duration(
//                     milliseconds: interaction.animationDuration,
//                   ),
//                   width: interaction.size.width,
//                   height: interaction.size.height,
//                   left: interaction.currentPosition.dx,
//                   top: interaction.currentPosition.dy,
//                   child: SelectedTaleInteractionObjectComponent(
//                     interaction: interaction,
//                   ),
//                 );
//               },
//             ),
//         ],
//       )