import 'package:flutter/cupertino.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class DefaultLocaleSelector extends StatelessWidget {
  const DefaultLocaleSelector({
    super.key,
    required this.locales,
    this.label,
    this.onSelected,
    this.value,
  });

  final String? label;
  final String? value;
  final ValueChanged<String>? onSelected;
  final List<String> locales;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DropdownComponent<String>(
        hintText: locales.isEmpty ? 'Empty' : null,
        label: label,
        menuWidth: 320,
        initialValue:
            value == null ? null : DropdownItem(value: value!, label: value!),
        onChanged: (value) {
          if (value == null || value.value == this.value) {
            return;
          }
          onSelected?.call(value.value);
        },
        items: [
          if (locales.isEmpty)
            DropdownItem(value: "empty", label: "Empty", enabled: false)
          else
            for (final value in locales)
              DropdownItem(value: value, label: value),
        ],
      ),
    );
  }
}
