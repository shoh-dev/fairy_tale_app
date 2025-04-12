import 'package:flutter/cupertino.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TextAlignSelector extends StatelessWidget {
  const TextAlignSelector({
    super.key,
    this.label = "Text Align",
    this.onSelected,
    this.value,
  });

  final String label;
  final TextAlign? value;
  final ValueChanged<TextAlign>? onSelected;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DropdownComponent<TextAlign>(
        label: label,
        menuWidth: 320,
        initialValue:
            value == null
                ? null
                : DropdownItem(value: value!, label: value!.name),
        onChanged: (value) {
          if (value == null || value.value == this.value) {
            return;
          }
          onSelected?.call(value.value);
        },
        items: [
          for (final value in TextAlign.values)
            DropdownItem(value: value, label: value.name),
        ],
      ),
    );
  }
}
