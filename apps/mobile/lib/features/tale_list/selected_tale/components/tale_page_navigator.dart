import 'package:flutter/material.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TalePageNavigatorComponent extends StatelessWidget {
  const TalePageNavigatorComponent({
    super.key,
    required this.controller,
    required this.totalPages,
    required this.interactions,
  });

  final PageController controller;
  final int totalPages;
  final List<TaleInteraction> interactions;

  bool isAllInteractionsUsed() {
    return interactions.every((interaction) => interaction.isUsed);
  }

  bool get hasClient => controller.hasClients;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_upward_rounded),
            onPressed:
                // () => controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut),
                hasClient && (controller.page ?? 0) > 0
                    ? () {
                        if (controller.page == 0) {
                          return;
                        } else {
                          controller.previousPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                        }
                      }
                    : null,
          ),
          SizedBox(width: 80, child: Center(child: TextComponent.any('${(controller.hasClients ? (controller.page?.toInt() ?? 0) : 0) + 1} / $totalPages'))),
          IconButton(
            icon: const Icon(Icons.arrow_downward_rounded),
            onPressed: isAllInteractionsUsed()
                ? hasClient && (controller.page ?? 0) < totalPages - 1
                    ? () {
                        if (controller.page == totalPages - 1) {
                          return;
                        } else {
                          controller.nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
                        }
                      }
                    : null
                : null,
          ),
        ],
      ),
    );
  }
}
