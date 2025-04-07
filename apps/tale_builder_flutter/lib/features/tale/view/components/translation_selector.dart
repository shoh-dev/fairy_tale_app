import 'package:flutter/cupertino.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TranslationSelector extends StatelessWidget {
  const TranslationSelector({
    super.key,
    required this.translations,
    this.label,
    this.onSelected,
    this.value,
  });

  final String? label;
  final String? value;
  final ValueChanged<String>? onSelected;
  final Map<String, String> translations;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DropdownComponent<String>(
        hintText: translations.entries.isEmpty ? 'Empty' : null,
        label: label,
        menuWidth: 320,
        initialValue:
            value == null ? null : DropdownItem(value: value!, label: value!),
        onChanged: (value) {
          // if (value?.value == 'add') {
          //   Navigator.of(context).push(
          //     MaterialPageRoute<void>(
          //       builder: (context) => const LocalizationSettingsPage(),
          //     ),
          //   );
          //   return;
          // }
          // if (value?.value == 'empty') {
          //   onChanged('');
          //   controller.clear();
          //   return;
          // }
          if (value == null || value.value == this.value) {
            return;
          }
          onSelected?.call(value.value);
        },
        items: [
          if (translations.entries.isEmpty)
            DropdownItem(value: "empty", label: "Empty", enabled: false)
          else
            // DropdownItem(
            //   value: 'add',
            //   label: 'Add translations',
            //   icon: Icons.add_rounded,
            // ),
            // if (!isRequiredToSelect)
            //   DropdownItem(
            //     value: 'empty',
            //     label: 'None',
            //     icon: Icons.clear_rounded,
            //   ),
            for (final value in translations.entries)
              DropdownItem(
                value: value.key,
                // label: '[${value.key}] ${value.value}',
                label: value.value,
              ),
        ],
      ),
    );
  }
}
