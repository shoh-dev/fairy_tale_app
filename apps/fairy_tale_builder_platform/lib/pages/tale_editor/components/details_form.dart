import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/pages/localization_settings/localization_settings_page.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TaleDetailsForm extends StatelessWidget {
  const TaleDetailsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: selectedTaleSelector,
      builder: (context, dispatch, tale) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Tale Details',
                  style: context.textTheme.headlineSmall,
                ),
                const Spacer(),
                ButtonComponent.iconOutlined(
                  icon: Icons.language_rounded,
                  tooltip: 'Localization Editor',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => const LocalizationSettingsPage(),
                      ),
                    );
                  },
                ),
                // const SizedBox(width: 8),
                // StateConnector<AppState, bool>(
                //   selector: isTaleEditedSelector,
                //   builder: (context, dispatch, isEdited) {
                //     return ButtonComponent.icon(
                //       icon: Icons.save_rounded,
                //       onPressed: isEdited
                //           ? () {
                //               dispatch(SaveTaleAction(tale));
                //             }
                //           : null,
                //     );
                //   },
                // ),
              ],
            ),
            space(8),
            Text(
              'ID: ${tale.id}',
              style: context.textTheme.titleMedium,
            ),
            space(16),
            TranslationSelector(
              label: 'Title',
              textKey: tale.title,
              onChanged: (value) {
                dispatch(UpdateSelectedTaleAction(tale.copyWith(title: value)));
              },
            ),
            space(),
            TranslationSelector(
              label: 'Description',
              textKey: tale.description,
              onChanged: (value) {
                dispatch(
                  UpdateSelectedTaleAction(
                    tale.copyWith(description: value),
                  ),
                );
              },
            ),
            space(),
            _OrientationDropdown(
              orientation: tale.orientation,
              onChanged: (value) {
                dispatch(
                  UpdateSelectedTaleAction(tale.copyWith(orientation: value)),
                );
              },
            ),
            space(),
            // Text(
            //   'Metadata',
            //   style: context.textTheme.headlineSmall,
            // ),
            // space(8),
            ImageSelectorComponent(
              title: 'Cover Image',
              imagePath: tale.coverImage,
            ),
          ],
        );
      },
    );
  }

  SizedBox space([num? space]) {
    return SizedBox(height: space?.toDouble() ?? 24);
  }
}

class _OrientationDropdown extends StatelessWidget {
  const _OrientationDropdown({
    required this.orientation,
    required this.onChanged,
  });

  final String orientation;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownComponent<String>(
      label: 'Orientation',
      initialValue: DropdownItem(value: orientation, label: orientation),
      onChanged: (value) {
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
