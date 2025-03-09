import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/pages/localization_settings/localization_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TranslationSelector extends StatelessWidget {
  const TranslationSelector({
    required this.label,
    required this.textKey,
    required this.onChanged,
    this.isRequiredToSelect = false,
    super.key,
  });

  final String label;
  final String? textKey;
  final ValueChanged<String> onChanged;
  final bool isRequiredToSelect;

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, TaleLocalization?>(
      selector: (state) => selectedTaleSelector(state).localizations,
      builder: (context, dispatch, model) {
        final defaultLocale = model?.defaultLocale ?? 'en';
        final translations =
            model?.translations[defaultLocale] ?? <String, String>{};

        return DropdownComponent<String>(
          label: label,
          // hintText: '$textKey: NOT_FOUND',
          hintText: textKey,
          autovalidateMode: AutovalidateMode.always,
          initialValue: textKey == null
              ? null
              : DropdownItem(
                  value: textKey!,
                  label: textKey!,
                ),
          validator: (value) {
            if (isRequiredToSelect) {
              if (translations.isEmpty) {
                return 'No translations found! Please add some.';
              }
              if (translations[value?.value] == null) {
                return 'Translation not found!';
              }
            }
            if (value != null && value.value.isNotEmpty) {
              if (translations[value.value] == null) {
                return 'Translation not found!';
              }
            }
            return null;
          },
          onChanged: (value, controller) {
            if (value?.value == 'add') {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const LocalizationSettingsPage(),
                ),
              );
              return;
            }
            if (value?.value == 'empty') {
              onChanged('');
              controller.clear();
              return;
            }
            if (value == null || value.value == textKey) {
              return;
            }
            onChanged(value.value);
          },
          items: [
            DropdownItem(
              value: 'add',
              label: 'Add translations',
              icon: Icons.add_rounded,
            ),
            if (!isRequiredToSelect)
              DropdownItem(
                value: 'empty',
                label: 'None',
                icon: Icons.clear_rounded,
              ),
            for (final value in translations.entries)
              DropdownItem(
                value: value.key,
                label: '[${value.key}] ${value.value}',
              ),
          ],
        );
      },
    );
  }
}
