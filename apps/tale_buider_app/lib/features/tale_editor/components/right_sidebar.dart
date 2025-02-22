import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';
import 'package:tale_buider_app/features/tale_editor/components/tale_details_form.dart';

class TaleEditorRightSidebarComponent extends StatelessWidget {
  const TaleEditorRightSidebarComponent({super.key, required this.tale});

  final Tale tale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
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
