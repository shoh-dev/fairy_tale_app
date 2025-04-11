import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_mobile_flutter/features/tale/view/components/body/tale_body.dart';
import 'package:tale_mobile_flutter/features/tale/view/my_tales_view.dart';
import 'package:tale_mobile_flutter/features/tale/view_model/tale_view_model.dart';

class TaleView extends StatelessWidget {
  const TaleView({super.key, required this.vm});

  static String route(String id) => "${MyTalesView.route()}/$id";

  final TaleViewModel vm;

  @override
  Widget build(BuildContext context) {
    return CommandWrapper(
      command: vm.fetchTaleCommand,
      okBuilder: (context, child) => child!,
      child: TaleBody(vm: vm),
    );
  }
}
