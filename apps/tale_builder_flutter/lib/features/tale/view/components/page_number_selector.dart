import 'package:flutter/cupertino.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class PageNumberSelector extends StatelessWidget {
  const PageNumberSelector({
    super.key,
    this.label = "Page Number",
    this.onSelected,
    this.value,
    required this.totalPages,
  });

  final String label;
  final int? value;
  final ValueChanged<int>? onSelected;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DropdownComponent<int>(
        label: label,
        menuWidth: 320,
        initialValue:
            value == null
                ? null
                : DropdownItem(value: value!, label: value!.toString()),
        onChanged: (value) {
          if (value == null || value.value == this.value) {
            return;
          }
          onSelected?.call(value.value);
        },
        items: [
          for (int i = 1; i <= totalPages; i++)
            DropdownItem(value: i, label: i.toString()),
        ],
      ),
    );
  }
}
