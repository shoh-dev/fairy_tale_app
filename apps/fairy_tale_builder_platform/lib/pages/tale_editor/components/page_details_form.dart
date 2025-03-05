import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/image_selector.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/tale_preview_dialog.dart';
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
        safeInitialize(() {
          pageTitleCtrl
            ..text = page.text
            ..addListener(() {
              // dispatch(
              // UpdateTalePageAction(page.copyWith(text: pageTitleCtrl.text)));
            });
        });
      },
      onDispose: (dispatch) {
        safeDispose(pageTitleCtrl.dispose);
      },
      onDidChange: (dispatch, state, page) {
        safeDidUpdateWidget(() {
          pageTitleCtrl.text = page.text;
        });
      },
      builder: (context, dispatch, page) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Page Details', style: context.textTheme.headlineSmall),
                const Spacer(),
                const ButtonComponent.icon(
                  icon: Icons.save_rounded,
                  // onPressed: () {
                  //   //todo:
                  // },
                ),
                const SizedBox(width: 8),
                const ButtonComponent.iconDesctructive(
                  icon: Icons.delete_rounded,
                  // onPressed: () {},
                  //todo: onPressed
                ),
                const SizedBox(width: 8),
                ButtonComponent.iconOutlined(
                  icon: Icons.close_rounded,
                  onPressed: () {
                    dispatch(SelectEditorTalePageAction(null));
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
            ButtonComponent.outlined(
              text: 'Preview Page',
              icon: Icons.remove_red_eye,
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => TalePreviewDialog(id: page.id),
                );
              },
            ),
            space(16),
            const ButtonComponent.outlined(
              text: 'Interactions Editor',
              icon: Icons.edit_rounded,
              // onPressed: () {
              //   // Navigator.of(context).push(
              //   // MaterialPageRoute<void>(
              //   // builder: (context) => const TalePageInteractionsEditor()),//todo:
              //   // );
              // },
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
