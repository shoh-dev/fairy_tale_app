import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TalePageNavigatorComponent extends StatelessWidget {
  const TalePageNavigatorComponent({super.key, required this.controller, required this.totalPages});

  final PageController controller;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_upward_rounded),
          onPressed: () {
            if (controller.page == 0) {
              return;
            } else {
              controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
            }
          },
        ),
        TextComponent.any('${(controller.hasClients ? (controller.page?.toInt() ?? 0) : 0) + 1} / $totalPages'),
        IconButton(
          icon: const Icon(Icons.arrow_downward_rounded),
          onPressed: () {
            if (controller.page == totalPages - 1) {
              return;
            } else {
              controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
            }
          },
        ),
      ],
    );
  }
}
