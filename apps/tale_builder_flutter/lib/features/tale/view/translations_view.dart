import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_builder_flutter/features/tale/view/components/translations_table.dart';
import 'package:tale_builder_flutter/features/tale/view_model/translations_view_model.dart';

class TranslationsView extends StatelessWidget {
  static String route(String id) => "/tale/$id/translations";

  const TranslationsView({super.key, required this.vm});

  final TranslationsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return CommandWrapper(
      command: vm.fetchLocalizationCommand,
      okBuilder: (context, child) => child!,
      child: TranslationsTable(vm: vm),
    );
  }
}
