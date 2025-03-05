import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TaleDetailsForm extends StatefulWidget {
  const TaleDetailsForm({
    super.key,
  });

  @override
  State<TaleDetailsForm> createState() => _TaleDetailsFormState();
}

class _TaleDetailsFormState extends State<TaleDetailsForm> with StateHelpers {
  final ValueNotifier<Tale?> taleNotifier = ValueNotifier(null);
  Tale? get tale => taleNotifier.value;
  set tale(Tale? value) => taleNotifier.value = value;

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: selectedTaleSelector,
      onInitialBuild: (dispatch, tale) {
        taleNotifier.addListener(() {
          dispatch(SetIsTaleEditedAction(newTale: taleNotifier.value));
        });
        safeInitialize(() {
          taleNotifier.value = tale;
        });
      },
      // onDispose: (dispatch) {
      //   safeDispose(taleNotifier.dispose);
      // },
      builder: (context, dispatch, model) {
        return ValueListenableBuilder(
          valueListenable: taleNotifier,
          builder: (context, tale, child) {
            if (tale == null) {
              return const SizedBox();
            }
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
                    StateConnector<AppState, bool>(
                      selector: isTaleEditedSelector,
                      builder: (context, dispatch, isEdited) {
                        return ButtonComponent.icon(
                          icon: Icons.save_rounded,
                          onPressed: isEdited
                              ? () {
                                  dispatch(SaveTaleAction(tale));
                                }
                              : null,
                        );
                      },
                    ),
                  ],
                ),
                if (tale.id.isNotEmpty) ...[
                  space(8),
                  Text(
                    'ID: ${tale.id}',
                    style: context.textTheme.titleMedium,
                  ),
                ],
                space(16),
                TextFieldComponent(
                  label: 'Title',
                  initialValue: tale.title,
                  onChanged: (value) {
                    if (tale.title == value) {
                      return;
                    }
                    this.tale = tale.copyWith(title: value);
                  },
                ),
                space(),
                TextFieldComponent(
                  label: 'Description',
                  initialValue: tale.description,
                  onChanged: (value) {
                    if (tale.description == value) {
                      return;
                    }
                    this.tale = tale.copyWith(description: value);
                  },
                ),
                space(),
                _OrientationDropdown(
                  orientation: tale.orientation,
                  onChanged: (value) {
                    if (value == null || tale.orientation == value) {
                      return;
                    }
                    this.tale = tale.copyWith(orientation: value);
                  },
                ),
                space(),
                ImageSelectorComponent(
                  title: 'Cover Image',
                  imagePath: tale.coverImage,
                ),
              ],
            );
          },
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
  final void Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownComponent<String>(
      label: 'Orientation',
      initialValue: DropdownItem(value: orientation, label: orientation),
      onChanged: (value) {
        if (value == null) {
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
