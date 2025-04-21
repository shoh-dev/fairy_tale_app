import 'package:fairy_tale_builder_platform/components/backbutton.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalepageAppBar extends StatelessWidget
    with StateConnectorMixin<Tale>
    implements PreferredSizeWidget {
  const TalepageAppBar({
    required this.controller,
    super.key,
  });

  final TabController controller;

  @override
  Widget builder(
    BuildContext context,
    Dispatcher<AppState> dispatch,
    Tale model,
  ) {
    return AppBar(
      centerTitle: false,
      title: Text(model.title),
      leading: const Backbutton(),
      actions: [
        const ButtonComponent.outlined(
          text: 'Save as Draft',
          icon: Icons.save_as,
        ),
        const SizedBox(width: 8),
        ButtonComponent.primary(
          text: 'Save',
          icon: Icons.save_rounded,
          onPressed: () {
            dispatch(SaveTaleAction());
          },
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade800),
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: _TabBar(controller: controller),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Tale selector(AppState state) => selectedTale(state);
}

class _TabBar extends StatelessWidget {
  const _TabBar({
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
            tab(
              'Tale',
              Icons.smart_toy_rounded,
              controller.index == 0,
            ),
            tab(
              'Pages',
              Icons.pages_rounded,
              controller.index == 1,
            ),
            tab(
              'Interactions',
              Icons.play_arrow_rounded,
              controller.index == 2,
            ),
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
