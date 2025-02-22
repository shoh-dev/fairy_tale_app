import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    super.key,
    required this.body,
    this.leftSidebar,
    this.title,
  });

  final Widget body;
  final Widget? leftSidebar;
  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Sizes.web.kAppBarHeight,
        title: title,
      ),
      body: Row(
        children: [
          if (leftSidebar != null) leftSidebar!,
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
