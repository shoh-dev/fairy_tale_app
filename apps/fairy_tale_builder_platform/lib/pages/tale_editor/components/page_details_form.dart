import 'package:fairy_tale_builder_platform/components/translation_selector.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/image_selector.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/tale_preview_dialog.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalePageDetailsForm extends StatelessWidget {
  const TalePageDetailsForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, TalePage>(
      selector: selectedTalePageSelector,
      builder: (context, dispatch, page) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Page Details',
                  style: context.textTheme.headlineSmall,
                ),
                const Spacer(),
                const ButtonComponent.iconDesctructive(
                  tooltip: 'Delete Page',
                  icon: Icons.delete_rounded,
                  // onPressed: () {},
                  //todo: onPressed
                ),
                const SizedBox(width: 8),
                //Interactions Editor icon button
                ButtonComponent.iconOutlined(
                  tooltip: 'Interactions Editor',
                  icon: Icons.touch_app_rounded,
                  onPressed: () {
                    // Navigator.of(context).push(
                    // MaterialPageRoute<void>(
                    // builder: (context) => const TalePageInteractionsEditor()),//todo:
                    // );
                  },
                ),
                const SizedBox(width: 8),
                //preview page icon button
                ButtonComponent.iconOutlined(
                  tooltip: 'Preview Page',
                  icon: Icons.remove_red_eye_rounded,
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) => TalePreviewDialog(id: page.id),
                    );
                  },
                ),
              ],
            ),
            space(8),
            Text('ID: ${page.id}', style: context.textTheme.titleMedium),
            space(16),
            TranslationSelector(
              label: 'Page Title',
              textKey: page.text,
              onChanged: (value) {
                dispatch(
                  UpdateSelectedTalePageAction(page.copyWith(text: value)),
                );
              },
            ),
            space(),
            ImageSelectorComponent(
              title: 'Background Image',
              imagePath: page.metadata.backgroundImageUrl,
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
