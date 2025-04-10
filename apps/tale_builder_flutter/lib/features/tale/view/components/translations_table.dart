import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_builder_flutter/features/tale/view/components/default_locale_selector.dart';
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
              leading: Transform.scale(
                scale: .8,
                child: ButtonComponent.iconOutlined(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onPressed: () {
                    void pop() {
                      if (context.mounted) {
                        context.pop(vm.localization);
                      }
                    }

                    if (vm.isChanged) {
                      PromptDialog.show(
                        "Do you want to save changes?",
                        onLeftClick: (close) {
                          close();
                          pop();
                        },
                        onRightClick: (close) {
                          vm.onSave().then((value) {
                            if (value) {
                              close();
                              pop();
                            }
                          });
                        },
                      );
                    } else {
                      pop();
                    }
                  },
                ),
              ),
              actions: [
                SizedBox(
                  width: 200,
                  child: DefaultLocaleSelector(
                    locales: vm.localization.availableLocales,
                    value: vm.locale,
                    onSelected: vm.onSelectLocale,
                  ),
                ),
                const SizedBox(width: 8),
                ButtonComponent.icon(
                  icon: Icons.add,
                  onPressed: vm.onAddNewTranslationEntry,
                ),
                const SizedBox(width: 8),
                ButtonComponent.icon(icon: Icons.save, onPressed: vm.onSave),
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
