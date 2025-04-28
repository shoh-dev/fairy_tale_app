import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_ui/myspace_ui.dart';

class DefaultLocaleSelector extends StatelessWidget {
  const DefaultLocaleSelector({
    super.key,
    required this.locales,
    this.label,
    this.onSelected,
    this.value,
    this.onAddLocale,
  });

  final String? label;
  final String? value;
  final ValueChanged<String>? onSelected;
  final List<String> locales;
  final ValueChanged<String>? onAddLocale;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: DropdownComponent<String>(
        hintText: locales.isEmpty ? 'Empty' : null,
        label: label,
        menuWidth: 320,
        initialValue:
            value == null ? null : DropdownItem(value: value!, label: value!),
        onChanged: (value) async {
          if (value == null || value.value == this.value) {
            return;
          }
          if (value.value == 'add' && onAddLocale != null) {
            final locale = await showDialog<String>(
              context: context,
              builder: (context) => _NewLocaleDialog(locales: locales),
            );
            if (locale != null) {
              onAddLocale!(locale);
            }
            return;
          }

          onSelected?.call(value.value);
        },
        items: [
          if (onAddLocale != null)
            DropdownItem(value: "add", icon: Icons.add, label: "Add"),

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

class _NewLocaleDialog extends StatelessWidget {
  const _NewLocaleDialog({required this.locales});

  final List<String> locales;

  @override
  Widget build(BuildContext context) {
    String locale = 'en';
    return AlertDialog(
      title: Text("Add locale"),
      content: LayoutComponent.column(
        mainAxisSize: MainAxisSize.min,
        spacing: 16,
        children: [
          TextFieldComponent(
            label: "Locale",
            hintText: "ex: en, ru, uz",
            autoFocus: true,
            onChanged: (value) {
              locale = value;
            },
          ),
          Text("Existing locale(s): ${locales.join(", ")}"),
        ],
      ),
      actions: [
        ButtonComponent.text(
          text: "Cancel",
          onPressed: () => Navigator.pop(context),
        ),
        ButtonComponent.text(
          text: "Add",
          onPressed: () {
            if (locales.contains(locale)) {
              return;
            }
            Navigator.pop(context, locale);
          },
        ),
      ],
    );
  }
}
