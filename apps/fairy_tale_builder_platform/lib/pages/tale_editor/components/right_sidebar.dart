import 'package:fairy_tale_builder_platform/pages/tale_editor/components/details_form.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TaleEditorRightSidebarComponent extends StatelessWidget {
  const TaleEditorRightSidebarComponent({
    required this.tale,
    super.key,
  });

  final Tale tale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(Sizes.kLayoutPadding),
      height: context.height,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: TaleDetailsForm(tale: tale),
    );
  }
}
