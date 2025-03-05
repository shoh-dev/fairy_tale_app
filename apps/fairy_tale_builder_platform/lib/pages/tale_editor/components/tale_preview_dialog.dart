import 'package:device_preview/device_preview.dart';
import 'package:fairy_tale_builder_platform/components/translator_component.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalePreviewDialog extends StatelessWidget {
  const TalePreviewDialog({
    required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: selectedTaleSelector,
      builder: (context, dispatch, tale) {
        final page =
            tale.talePages.firstWhereOrNull((element) => element.id == id);

        return AlertDialog(
          title: Row(
            children: [
              const Text('Page Preview'),
              const Spacer(),
              ButtonComponent.iconOutlined(
                icon: Icons.close_rounded,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          content: SizedBox(
            width: tale.isPortrait ? 480 : 720,
            height: tale.isPortrait ? 720 : 480,
            child: page != null
                ? DeviceFrame(
                    device: Devices.ios.iPhone13,
                    orientation: tale.isPortrait
                        ? Orientation.portrait
                        : Orientation.landscape,
                    screen: Stack(
                      children: [
                        //image
                        if (page.backgroundImage.isNotEmpty)
                          Positioned.fill(
                            child: Image.network(
                              page.backgroundImage,
                              fit: BoxFit.cover,
                            ),
                          ),

                        for (final interaction in page.taleInteractions)
                          //tale object
                          AnimatedPositioned(
                            // curve: Curves.easeInOutCubicEmphasized,//todo: get curve from db
                            duration: Duration(
                              milliseconds: interaction.animationDuration,
                            ),
                            width: interaction.size.width,
                            height: interaction.size.height,
                            left: interaction.currentPosition.dx,
                            top: interaction.currentPosition.dy,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Translator(
                                toTranslate: [
                                  interaction.hintKey,
                                ],
                                builder: (translatedValue) => Tooltip(
                                  message: translatedValue[0],
                                  showDuration: const Duration(seconds: 5),
                                  child: Container(
                                    width: interaction.size.width,
                                    height: interaction.size.height,
                                    decoration: !interaction.metadata.hasImage
                                        ? BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color:
                                                    Colors.black.withAlpha(100),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          )
                                        : null,
                                    child: interaction.metadata.hasImage
                                        ? Image.network(
                                            interaction.metadata.imageUrl,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      'Page not found ($id)',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
          ),
          // actions: [
          //   ButtonComponent.outlined(
          //     text: 'Close',
          //     onPressed: Navigator.of(context).pop,
          //   ),
          // ],
        );
      },
    );
  }
}
