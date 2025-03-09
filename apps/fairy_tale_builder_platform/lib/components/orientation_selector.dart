import 'package:flutter/widgets.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class OrientationSelector extends StatelessWidget {
  const OrientationSelector({
    required this.orientation,
    required this.onChanged,
    this.hasLabel = true,
    super.key,
  });

  final String orientation;
  final void Function(String) onChanged;
  final bool hasLabel;

  @override
  Widget build(BuildContext context) {
    return DropdownComponent<String>(
      label: hasLabel ? 'Orientation' : null,
      initialValue: DropdownItem(value: orientation, label: orientation),
      onChanged: (value, controller) {
        if (value == null || value.value == orientation) {
          return;
        }
        onChanged(value.value);
      },
      items: [
        for (final orientation in ['portrait', 'landscape'])
          DropdownItem(
            value: orientation,
            label: orientation,
          ),
      ],
    );
  }
}
