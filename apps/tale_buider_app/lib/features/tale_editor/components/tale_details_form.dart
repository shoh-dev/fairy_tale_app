import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

class TaleDetailsForm extends StatelessWidget {
  const TaleDetailsForm({super.key, required this.tale});

  final Tale tale;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tale Details", style: context.textTheme.headlineSmall),
        if (tale.id.isNotEmpty) ...[
          space(8),
          Text("ID: ${tale.id}", style: context.textTheme.titleMedium),
          //todo: uncomment when date is added to tale
          // Text("Created Date: ${tale.date}", style: context.textTheme.titleMedium),
        ],
        space(16),
        TextFieldComponent(
          label: "Title",
          initialValue: tale.title,
          onChanged: (value) {
            context.dispatch(UpdateSelectedTaleAction(tale.copyWith(title: value)));
          },
        ),
        space(),
        TextFieldComponent(
          label: "Description",
          initialValue: tale.description,
          onChanged: (value) {
            context.dispatch(UpdateSelectedTaleAction(tale.copyWith(description: value)));
          },
        ),
        space(),
        _OrientationDropdown(tale: tale),
      ],
    );
  }

  SizedBox space([num? space]) {
    return SizedBox(height: space?.toDouble() ?? 24);
  }
}

class _OrientationDropdown extends StatelessWidget {
  const _OrientationDropdown({required this.tale});

  final Tale tale;

  @override
  Widget build(BuildContext context) {
    return DropdownComponent<String>(
      label: "Orientation",
      initialValue: DropdownItem(value: tale.orientation, label: tale.orientation),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        context.dispatch(UpdateSelectedTaleAction(tale.copyWith(orientation: value.value)));
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
