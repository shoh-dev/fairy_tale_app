import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/model/page.dart';
import 'package:tale_builder_flutter/features/tale/view/components/page_number_selector.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class RightBarPageForm extends StatelessWidget {
  const RightBarPageForm({super.key, required this.vm, required this.page});

  final TaleViewModel vm;
  final TalePageModel page;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: EdgeInsets.all(8),
      title: RepaintBoundary(
        child: LayoutComponent.row(
          spacing: 4,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.pages_rounded, size: 18),
            TextComponent.any('Page', style: context.textTheme.titleMedium),
          ],
        ),
      ),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Page Fields
        PageNumberSelector(
          totalPages: vm.pages.length,
          value: page.pageNumber,
          onSelected: vm.onChangePageNumber,
        ),
        const SizedBox(height: 8),

        if (page.hasImage) ...[
          //Replace
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ButtonComponent.outlined(
              text: "Replace background image",
              icon: Icons.upload_rounded,
              onPressed: vm.onChangePageBackgroundImage,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ButtonComponent.destructive(
              text: "Remove background image",
              icon: Icons.delete_outline,
              onPressed: vm.onDeletePageBackgroundImage,
            ),
          ),
          //Delete
        ] else
          //Add
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ButtonComponent.outlined(
              text: "Add background image",
              icon: Icons.image_outlined,
              onPressed: vm.onChangePageBackgroundImage,
            ),
          ),
      ],
    );
  }
}
