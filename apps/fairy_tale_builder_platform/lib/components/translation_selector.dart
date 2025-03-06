import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TranslationSelector extends StatelessWidget {
  const TranslationSelector({
    required this.label,
    required this.textKey,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String textKey;
  final ValueChanged<String> onChanged;

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
          initialValue: DropdownItem(
            value: textKey,
            label: textKey,
          ),
          onChanged: (value) {
            if (value == null || value.value == textKey) {
              return;
            }
            onChanged(value.value);
          },
          items: [
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
