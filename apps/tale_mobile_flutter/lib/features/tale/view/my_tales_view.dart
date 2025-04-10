import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_mobile_flutter/features/tale/view/components/body/body.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/my_tales_view_model.dart';

class MyTalesView extends StatelessWidget {
  final MyTalesViewModel vm;

  static String route() => "/my_tales";

  const MyTalesView({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return CommandWrapper(
      command: vm.fetchMyTalesCommand,
      okBuilder: (context, child) => child!,
      child: VmProvider(
        vm: vm,
        builder:
            (context, child) => Row(
              children: [
                //Left bar

                //Body
                Expanded(child: MyTalesBody(vm: vm)),

                //Right bar
              ],
            ),
      ),
    );
  }
}
