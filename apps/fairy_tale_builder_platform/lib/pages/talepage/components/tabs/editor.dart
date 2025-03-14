import 'package:fairy_tale_builder_platform/pages/talepage/components/forms/page_form.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/pagelist.dart';
import 'package:fairy_tale_builder_platform/pages/talepage/components/pagepreview.dart';
import 'package:flutter/material.dart';

class TalepageEditor extends StatelessWidget {
  const TalepageEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //pages
        TalepagePagesList(),

        //form
        TalepagePageForm(),

        //preview
        TalepagePagePreview(),
      ],
    );
  }
}
