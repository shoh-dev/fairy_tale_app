import 'package:fairy_tale_builder_platform/components/backbutton.dart';
import 'package:fairy_tale_builder_platform/manager/redux/mixin.dart';
import 'package:fairy_tale_builder_platform/manager/redux/selected_tale_state/selected_tale_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/tabbar.dart';
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
      actions: const [
        ButtonComponent.outlined(
          text: 'Share',
          icon: Icons.share_rounded,
        ),
        SizedBox(width: 8),
        ButtonComponent.primary(
          text: 'Save',
          icon: Icons.save_rounded,
        ),
        SizedBox(width: 8),
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
        child: TalepageTabBar(controller: controller),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Tale selector(AppState state) => selectedTale(state);
}
