import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/body/page_viewer.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  Widget build(BuildContext context) {
    final page = vm.selectedPage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.surfaceContainer,
        // shape: Border(
        // bottom: BorderSide(color: context.colorScheme.outlineVariant),
        // ),
        titleSpacing: 0,
        title: ListTile(
          title: Text('Story Canvas'),
          leading: Icon(Icons.book_outlined),
        ),
        actions: [
          ButtonComponent.outlined(
            text: "Preview",
            icon: Icons.remove_red_eye_rounded,
            onPressed: () {},
          ), //todo: implement preview
          const SizedBox(width: 16),

          ButtonComponent.primary(
            text: "Save",
            icon: Icons.save,
            onPressed: vm.onSave,
          ), //todo: implement save
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        height: context.height,
        color: context.colorScheme.surface,
        alignment: Alignment.center,
        child:
            page != null
                ? PageViewer(vm: vm)
                : TextComponent.any(
                  "Page is not selected!",
                  style: context.textTheme.headlineSmall,
                ),
      ),
    );
  }
}
