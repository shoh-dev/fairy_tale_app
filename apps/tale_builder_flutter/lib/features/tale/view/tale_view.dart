import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/body/body.dart';
import 'package:tale_builder_flutter/features/tale/view/components/create_tale_form.dart';
import 'package:tale_builder_flutter/features/tale/view/components/left_bar.dart';
import 'package:tale_builder_flutter/features/tale/view/components/right_bar/right_bar.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

abstract class Sizes {
  static Size deviceSize(bool isPortrait) {
    //SE 375 x 667
    //XR 414 x 896
    //X, 11Pro 375 x 812
    //iPad Mini (6th gen) 744 x 1133
    //iPad mini a17 2266 x 1488
    final device = Devices.ios.iPhone13;
    final screenSize = device.screenSize;
    if (isPortrait) return screenSize;
    return Size(screenSize.height, screenSize.width);
  }
}

class TaleView extends StatelessWidget {
  static String route([String? id]) => "/tale/${id ?? "new"}";

  const TaleView({super.key});

  @override
  Widget build(BuildContext context) {
    final isCreate = context.select<TaleViewModel, bool>(
      (value) => value.isCreate,
    );
    if (isCreate) {
      return CreateTaleForm();
    }

    final command = context.read<TaleViewModel>().fetchTaleCommand;
    return CommandWrapper(
      command: command,
      okBuilder: (context, child) => child!,
      child: LayoutComponent.row(
        // spacing: 16,
        children: [
          //Left Sidebar: shows list of pages and add page at the bottom
          const Expanded(flex: 1, child: LeftBar()),

          const VerticalDivider(color: Colors.transparent),

          //Body: shows selected page info, where user can align text or objects
          const Expanded(flex: 3, child: Body()),

          const VerticalDivider(color: Colors.transparent),

          //Right Sidebar: if page is selected, shows page form, else shows tale form
          const Expanded(flex: 1, child: RightBar()),
        ],
      ),
    );
  }
}
