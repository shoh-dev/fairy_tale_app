import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TalepageTabBar extends StatelessWidget {
  const TalepageTabBar({
    super.key,
    required this.controller,
  });

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return TabBar(
          controller: controller,
          dividerHeight: 0,
          tabAlignment: TabAlignment.center,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: Colors.grey,
          unselectedLabelStyle: context.textTheme.labelSmall,
          labelStyle: context.textTheme.labelSmall,
          splashBorderRadius: BorderRadius.circular(16),
          indicatorColor: Colors.transparent,
          tabs: [
            tab('Editor', Icons.layers_rounded, controller.index == 0),
            tab(
              'Interactions',
              Icons.workspaces_rounded,
              controller.index == 1,
            ),
            tab('Preview', Icons.preview_rounded, controller.index == 2),
            tab('Settings', Icons.settings_rounded, controller.index == 3),
          ],
        );
      },
    );
  }

  Tab tab(String text, IconData icon, bool isSelected) {
    return Tab(
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade800 : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
