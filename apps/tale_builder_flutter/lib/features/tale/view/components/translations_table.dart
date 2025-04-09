import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view_model/translations_view_model.dart';

class TranslationsTable extends StatelessWidget {
  const TranslationsTable({super.key, required this.vm});

  final TranslationsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return VmProvider(
      vm: vm,
      builder:
          (context, child) => Scaffold(
            appBar: AppBar(
              title: Text("Translations Editor"),
              centerTitle: true,
              actions: [
                ButtonComponent.icon(icon: Icons.add),
                const SizedBox(width: 8),
                ButtonComponent.icon(icon: Icons.save),
                const SizedBox(width: 8),
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Key",
                          style: context.textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Value",
                          style: context.textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.json.length,
                    itemBuilder: (context, index) {
                      final entry = vm.json.entries.elementAt(index);
                      return ListTile(
                        key: ValueKey(index),
                        dense: true,
                        title: Row(
                          spacing: 16,
                          children: [
                            Expanded(child: TextField(controller: entry.key)),
                            Expanded(child: TextField(controller: entry.value)),
                            ButtonComponent.iconDesctructive(
                              icon: Icons.delete,
                              onPressed: () {
                                vm.onRemoveEntry(index);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
