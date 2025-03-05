import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
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
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: (state) => state.taleListState.taleState.selectedTale,
      onInitialBuild: (dispatch, tale) {
        titleCtrl.text = tale.title;
        descriptionCtrl.text = tale.description;
        titleCtrl.addListener(() {
          // context.dispatch(UpdateSelectedTaleAction(
          // widget.tale.copyWith(title: titleCtrl.text)));//todo:
        });
        descriptionCtrl.addListener(() {
          // context.dispatch(UpdateSelectedTaleAction(
          // widget.tale.copyWith(description: descriptionCtrl.text)));
        });
      },
      onDispose: (dispatch) {
        titleCtrl.dispose();
        descriptionCtrl.dispose();
      },
      onDidChange: (dispatch, state, tale) {
        titleCtrl.text = tale.title;
        descriptionCtrl.text = tale.description;
      },
      builder: (context, dispatch, tale) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tale Details', style: context.textTheme.headlineSmall),
            if (tale.id.isNotEmpty) ...[
              space(8),
              Text('ID: ${tale.id}', style: context.textTheme.titleMedium),
              //todo: uncomment when date is added to tale
              // Text("Created Date: ${tale.date}", style: context.textTheme.
              // titleMedium),
            ],
            space(16),
            TextFieldComponent(
              label: 'Title',
              controller: titleCtrl,
            ),
            space(),
            TextFieldComponent(
              label: 'Description',
              controller: descriptionCtrl,
            ),
            space(),
            _OrientationDropdown(tale: tale),
            space(),
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
  const _OrientationDropdown({required this.tale});

  final Tale tale;

  @override
  Widget build(BuildContext context) {
    return DropdownComponent<String>(
      label: 'Orientation',
      initialValue:
          DropdownItem(value: tale.orientation, label: tale.orientation),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        // context.dispatch(
        // UpdateSelectedTaleAction(tale.copyWith(orientation: value.value)));//todo:
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
