import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_builder_flutter/features/tale/view/tale_editor.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class TaleView extends StatelessWidget {
  final TaleViewModel vm;

  static String route(String id) => "/tale/$id";

  const TaleView({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return TaleEditor(vm: vm);
    return CommandWrapper(
      command: vm.fetchTaleCommand,
      okBuilder: (context, child) => child!,
      child: CommandWrapper(
        command: vm.fetchLocalizationCommand,
        okBuilder: (context, child) => child!,
        child: CommandWrapper(
          command: vm.fetchPagesCommand,
          okBuilder: (context, child) => child!,
          child: TaleEditor(vm: vm),
        ),
      ),
    );
  }
}
