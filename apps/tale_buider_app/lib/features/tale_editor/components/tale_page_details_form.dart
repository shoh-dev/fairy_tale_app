import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

import 'image_selector.dart';

class TalePageDetailsForm extends StatefulWidget {
  const TalePageDetailsForm({super.key, required this.page});

  final TalePage page;

  @override
  State<TalePageDetailsForm> createState() => _TalePageDetailsFormState();
}

class _TalePageDetailsFormState extends State<TalePageDetailsForm> with StateHelpers {
  TalePage get page => widget.page;

  final TextEditingController pageTitleCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    safeInitialize(() {
      pageTitleCtrl.text = page.text;
      pageTitleCtrl.addListener(() {
        context.dispatch(UpdateSelectedTalePageAction(page.copyWith(text: pageTitleCtrl.text)));
      });
    });
  }

  @override
  void didUpdateWidget(covariant TalePageDetailsForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.page != page) {
      pageTitleCtrl.text = page.text;
    }
  }

  @override
  void dispose() {
    pageTitleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Page Details", style: context.textTheme.headlineSmall),
        if (page.id.isNotEmpty) ...[
          space(8),
          Text("Page Number: ${page.pageNumber}", style: context.textTheme.titleMedium),
          space(4),
          Text("ID: ${page.id}", style: context.textTheme.titleMedium),
        ],
        space(16),
        TextFieldComponent(
          label: "Page Title",
          controller: pageTitleCtrl,
        ),
        space(),
        ImageSelectorComponent(
          title: "Background Image",
          imagePath: page.backgroundImage,
        ),
      ],
    );
  }

  SizedBox space([num? space]) {
    return SizedBox(height: space?.toDouble() ?? 24);
  }
}
