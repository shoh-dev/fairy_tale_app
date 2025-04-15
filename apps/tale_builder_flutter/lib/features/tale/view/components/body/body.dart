import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/body/page_viewer.dart';
import 'package:tale_builder_flutter/features/tale/view/components/preview_wrapper.dart';
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
          const SizedBox(width: 16),
          ButtonComponent.outlined(
            text: vm.isPreviewMode ? "Edit" : "Preview",
            icon: vm.isPreviewMode ? Icons.edit : Icons.remove_red_eye_rounded,
            onPressed:
                vm.selectedPageId.isNotEmpty ? vm.togglePreviewMode : null,
          ), //todo: implement preview
          const SizedBox(width: 16),

          ButtonComponent.primary(
            text: "Save",
            icon: Icons.save,
            onPressed: vm.isPreviewMode ? null : vm.onSave,
          ), //todo: implement save
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton:
          vm.selectedPageId.isEmpty
              ? null
              : PreviewWrapper(
                isPreviewMode: vm.isPreviewMode,
                child: _ObjectSelector(vm: vm),
              ),
      body: Stack(
        children: [
          Container(
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

          // if (vm.selectedPage != null) _ObjectSelector(vm: vm),
        ],
      ),
    );
  }
}

class _ObjectSelector extends StatelessWidget {
  const _ObjectSelector({required this.vm});

  final TaleViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add_outlined,
      activeIcon: Icons.close_outlined,
      children: [
        SpeedDialChild(
          onTap: vm.onAddText,
          label: "Text",
          child: Icon(Icons.text_fields),
        ),
        for (final object in vm.objects)
          SpeedDialChild(
            onTap: () {},
            label: "Boy",
            child: Image.network(
              object.imageUrl,
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),
      ],
    );
  }
}
