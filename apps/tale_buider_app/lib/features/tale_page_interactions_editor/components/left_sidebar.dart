import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

class InteractionLeftSidebarComponent extends StatelessWidget {
  const InteractionLeftSidebarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: context.height,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
        child: const Column(
          spacing: 16,
          children: [
            //todo: come up with something to use left sidebar
          ],
        ),
      ),
    );
  }
}
