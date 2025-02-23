import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

class TalePreviewDialog extends StatelessWidget {
  const TalePreviewDialog({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<Tale>(
        converter: (store) => store.state.taleState.selectedTale,
        builder: (context, tale) {
          final page = tale.talePages.firstWhereOrNull((element) => element.id == id);

          return AlertDialog(
            title: const Text("Page Preview"),
            content: Container(
              width: tale.isPortrait ? 480 : 720,
              height: tale.isPortrait ? 720 : 480,
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.primary),
              ),
              child: page != null
                  ? Stack(
                      children: [
                        //image
                        if (page.backgroundImage.isNotEmpty)
                          Positioned.fill(
                              child: Image.network(
                            page.backgroundImage,
                            fit: BoxFit.cover,
                          )),

                        for (var interaction in page.taleInteractions)
                          //tale object
                          AnimatedPositioned(
                            // curve: Curves.easeInOutCubicEmphasized,//todo: get curve from db
                            duration: Duration(milliseconds: interaction.animationDuration),
                            width: interaction.size.width,
                            height: interaction.size.height,
                            left: interaction.currentPosition.dx,
                            top: interaction.currentPosition.dy,
                            child: Tooltip(
                              triggerMode: TooltipTriggerMode.longPress,
                              message: context.taleTr(interaction.hintKey),
                              showDuration: const Duration(seconds: 5),
                              child: Container(
                                width: interaction.size.width,
                                height: interaction.size.height,
                                decoration: interaction.objectImageUrl.isEmpty
                                    ? BoxDecoration(border: Border.all(color: Colors.black, width: 1), borderRadius: BorderRadius.circular(10), boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ])
                                    : null,
                                child: interaction.objectImageUrl.isNotEmpty ? Image.network(interaction.objectImageUrl) : null,
                              ),
                            ),
                          ),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Page not found ($id)",
                        style: context.textTheme.titleLarge,
                      ),
                    ),
            ),
            actions: [
              ButtonComponent.outlined(text: "Close", onPressed: Navigator.of(context).pop),
            ],
          );
        });
  }
}
