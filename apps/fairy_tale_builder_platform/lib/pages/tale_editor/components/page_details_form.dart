import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TalePageDetailsForm extends StatefulWidget {
  const TalePageDetailsForm({
    super.key,
  });

  @override
  State<TalePageDetailsForm> createState() => _TalePageDetailsFormState();
}

class _TalePageDetailsFormState extends State<TalePageDetailsForm>
    with StateHelpers {
  final TextEditingController pageTitleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, TalePage>(
      selector: (state) =>
          state.taleListState.taleState.editorState.selectedTalePage,
      onInitialBuild: (dispatch, page) {
        pageTitleCtrl
          ..text = page.text
          ..addListener(() {
            // dispatch(
            // UpdateTalePageAction(page.copyWith(text: pageTitleCtrl.text)));
          });
      },
      onDispose: (dispatch) {
        pageTitleCtrl.dispose();
      },
      onDidChange: (dispatch, state, page) {
        pageTitleCtrl.text = page.text;
      },
      builder: (context, dispatch, page) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Page Details', style: context.textTheme.headlineSmall),
                ButtonComponent.icon(
                  icon: Icons.save_rounded,
                  onPressed: () {
                    //todo:
                  },
                ),
              ],
            ),
            if (page.id.isNotEmpty) ...[
              space(8),
              Text('ID: ${page.id}', style: context.textTheme.titleMedium),
              // space(4),
              // Text("Page Number: ${page.pageNumber}", style: context.textTheme.
              // titleMedium),
            ],
            space(16),
            const ButtonComponent.destructive(
              text: 'Delete Page',
              icon: Icons.delete_rounded,
              //todo: onPressed
            ),
            space(16),
            ButtonComponent.outlined(
              text: 'Preview Page',
              icon: Icons.remove_red_eye,
              onPressed: () {
                // showDialog(
                // context: context,
                // builder: (context) {
                // return TalePreviewDialog(id: page.id);
                // });//todo:
              },
            ),
            space(16),
            ButtonComponent.outlined(
              text: 'Interactions Editor',
              icon: Icons.edit_rounded,
              onPressed: () {
                // Navigator.of(context).push(
                // MaterialPageRoute<void>(
                // builder: (context) => const TalePageInteractionsEditor()),//todo:
                // );
              },
            ),
            space(16),
            TextFieldComponent(
              label: 'Page Title',
              controller: pageTitleCtrl,
            ),
            space(),
            ImageSelectorComponent(
              title: 'Background Image',
              imagePath: page.backgroundImage,
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
