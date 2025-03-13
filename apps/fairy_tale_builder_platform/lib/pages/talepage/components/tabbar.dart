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
    return TabBar(
      controller: controller,
      dividerHeight: 0,
      tabAlignment: TabAlignment.center,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: Colors.grey,
      unselectedLabelStyle: context.textTheme.labelSmall,
      labelStyle: context.textTheme.labelSmall,
      splashBorderRadius: BorderRadius.circular(16),
      tabs: const [
        Tab(
          text: 'Editor',
          icon: Icon(Icons.layers_rounded),
        ),
        Tab(
          text: 'Interactions',
          icon: Icon(Icons.layers_rounded),
        ),
        Tab(
          text: 'Preview',
          icon: Icon(Icons.preview_rounded),
        ),
        Tab(
          text: 'Settings',
          icon: Icon(Icons.settings_rounded),
        ),
      ],
    );
  }
}
