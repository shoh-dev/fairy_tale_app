import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

import 'image_selector.dart';

class TaleDetailsForm extends StatefulWidget {
  const TaleDetailsForm({super.key, required this.tale});

  final Tale tale;

  @override
  State<TaleDetailsForm> createState() => _TaleDetailsFormState();
}

class _TaleDetailsFormState extends State<TaleDetailsForm> with StateHelpers {
  Tale get tale => widget.tale;

  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController descriptionCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    safeInitialize(() {
      titleCtrl.text = tale.title;
      descriptionCtrl.text = tale.description;
      titleCtrl.addListener(() {
        context.dispatch(UpdateSelectedTaleAction(widget.tale.copyWith(title: titleCtrl.text)));
      });
      descriptionCtrl.addListener(() {
        context.dispatch(UpdateSelectedTaleAction(widget.tale.copyWith(description: descriptionCtrl.text)));
      });
    });
  }

  @override
  void dispose() {
    safeDispose(() {
      titleCtrl.dispose();
      descriptionCtrl.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tale Details", style: context.textTheme.headlineSmall),
        if (widget.tale.id.isNotEmpty) ...[
          space(8),
          Text("ID: ${widget.tale.id}", style: context.textTheme.titleMedium),
          //todo: uncomment when date is added to tale
          // Text("Created Date: ${tale.date}", style: context.textTheme.titleMedium),
        ],
        space(16),
        TextFieldComponent(
          label: "Title",
          controller: titleCtrl,
        ),
        space(),
        TextFieldComponent(
          label: "Description",
          controller: descriptionCtrl,
        ),
        space(),
        _OrientationDropdown(tale: widget.tale),
        space(),
        ImageSelectorComponent(
          title: "Cover Image",
          imagePath: widget.tale.coverImage,
        ),
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
