import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    required this.body,
    super.key,
    this.leftSidebar,
    this.rigthSidebar,
    this.title,
    this.leading,
  });

  final Widget body;
  final Widget? leftSidebar;
  final Widget? rigthSidebar;
  final Widget? title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Sizes.kAppBarHeight,
        title: title,
        leading: leading,
        leadingWidth: Sizes.kLeftSidebarWidth,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leftSidebar != null) leftSidebar!,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainer,
              ),
              height: context.height,
              padding: const EdgeInsets.all(Sizes.kLayoutPadding),
              child: body,
            ),
          ),
          if (rigthSidebar != null) rigthSidebar!,
        ],
      ),
    );
  }
}
