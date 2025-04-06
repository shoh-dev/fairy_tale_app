import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/body/body.dart';
import 'package:tale_builder_flutter/features/tale/view/components/left.dart';
import 'package:tale_builder_flutter/features/tale/view/components/right.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

abstract class Sizes {
  static Size deviceSize(bool isPortrait) {
    if (isPortrait) return Size(380, 720);
    return Size(720, 380);
  }
}

class TaleView extends StatelessWidget {
  final TaleViewModel vm;

  static String route([String? id]) => "/tale/${id ?? "new"}";

  const TaleView({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return LayoutComponent.row(
      spacing: 16,
      children: [
        //Left Sidebar: shows list of pages and add page at the bottom
        Expanded(flex: 1, child: LeftBar(vm: vm)),

        const VerticalDivider(),

        //Body: shows selected page info, where user can align text or objects
        Expanded(flex: 3, child: Body(vm: vm)),

        const VerticalDivider(),

        //Right Sidebar: if page is selected, shows page form, else shows tale form
        Expanded(flex: 1, child: RightBar(vm: vm)),
      ],
    );
  }
}
