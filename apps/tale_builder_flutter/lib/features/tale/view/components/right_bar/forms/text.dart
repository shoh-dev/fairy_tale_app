import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/model/text.dart';
import 'package:tale_builder_flutter/features/tale/view/components/translation_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/tale_view.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class RightBarTextForm extends StatelessWidget {
  const RightBarTextForm({super.key, required this.vm, required this.text});

  final TaleViewModel vm;
  final TalePageTextModel text;

  @override
  Widget build(BuildContext context) {
    final tale = vm.tale;
    final loc = vm.localization;
    final deviceSize = Sizes.deviceSize(tale.isPortrait);
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(8),
      title: RepaintBoundary(
        child: LayoutComponent.row(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.text_fields_outlined, size: 18),
            TextComponent.any('Text', style: context.textTheme.titleMedium),
          ],
        ),
      ),
      children: [
        // ButtonComponent.destructive(
        //   text: "Delete Text",
        //   icon: Icons.delete_outlined,
        //   onPressed: () => vm.onDeleteText(vm.selectedTextId),
        // ).expanded(),
        // const SizedBox(height: 16),
        //Text Fields
        TranslationSelector(
          label: "Text",
          translations: loc.defaultTranslations,
          value: text.text,
          onSelected: vm.onChangeTextText,
        ),
        const SizedBox(height: 16),
        SliderComponent(
          label: "Width",
          min: 1,
          max: deviceSize.width - text.dx,
          initialValue: text.width,
          onChanged: (value) {
            vm.onChangeTextSize(value, null);
          },
        ),
        const SizedBox(height: 16),
        SliderComponent(
          label: "Height",
          min: 1,
          max: deviceSize.height - text.dy,
          initialValue: text.height,
          onChanged: (value) {
            vm.onChangeTextSize(null, value);
          },
        ),
        const SizedBox(height: 16),
        SliderComponent(
          label: "X Postion",
          min: 0,
          max: deviceSize.width - text.width,
          initialValue: text.dx,
          onChanged: (value) {
            vm.onChangeTextPosition(value, null);
          },
        ),
        const SizedBox(height: 16),
        SliderComponent(
          label: "Y Position",
          min: 0,
          max: deviceSize.height - text.height,
          initialValue: text.dy,
          onChanged: (value) {
            vm.onChangeTextPosition(null, value);
          },
        ),

        TextFieldComponent(
          label: "Font Size",
          initialValue: text.style?.fontSize.toString(),
          onChanged: (value) {
            final parsed = double.tryParse(value);
            if (parsed == null) return;
            vm.onChangeTextFontSize(parsed);
          },
        ),

        // SliderComponent(
        //   label: "Font Size",
        //   min: 12,
        //   max: 40,
        //   initialValue: text.style?.fontSize,
        //   onChanged: (value) {
        //     if (value == null) return;
        //     vm.onChangeTextFontSize(value);
        //   },
        // ),
      ],
    );
  }
}
