import 'package:flutter/cupertino.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class OrientationSelector extends StatelessWidget {
  const OrientationSelector({
    super.key,
    this.label = "Orientation",
    this.onSelected,
    this.value,
  });

  final String label;
  final String? value;
  final ValueChanged<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DropdownComponent<String>(
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
          for (final value in Orientation.values)
            DropdownItem(value: value.name, label: value.name),
        ],
      ),
    );
  }
}
