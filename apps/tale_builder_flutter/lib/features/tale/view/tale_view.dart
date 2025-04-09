import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/body/body.dart';
import 'package:tale_builder_flutter/features/tale/view/components/left_bar.dart';
import 'package:tale_builder_flutter/features/tale/view/components/right_bar/right_bar.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

abstract class Sizes {
  static Size deviceSize(bool isPortrait) {
    //SE 375 x 667
    //XR 414 x 896
    //X, 11Pro 375 x 812
    //iPad Mini (6th gen) 744 x 1133
    if (isPortrait) return Size(375, 812);
    return Size(812, 375);
  }
}

class TaleView extends StatelessWidget {
  final TaleViewModel vm;

  static String route([String? id]) => "/tale/${id ?? "new"}";

  const TaleView({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return CommandWrapper(
      command: vm.fetchTaleCommand,
      okBuilder: (context, child) => child!,
      child: VmProvider(
        vm: vm,
        builder: (context, child) {
          return LayoutComponent.row(
            // spacing: 16,
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
        },
      ),
    );
  }
}
