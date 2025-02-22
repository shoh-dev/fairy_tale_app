import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    super.key,
    required this.body,
    this.leftSidebar,
    this.rigthSidebar,
    this.title,
  });

  final Widget body;
  final Widget? leftSidebar;
  final Widget? rigthSidebar;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Sizes.web.kAppBarHeight,
        title: title,
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
              padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
              child: body,
            ),
          ),
          if (rigthSidebar != null) rigthSidebar!,
        ],
      ),
    );
  }
}
