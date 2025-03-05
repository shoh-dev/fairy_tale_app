import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
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
  final ValueNotifier<TalePage?> pageNotifier = ValueNotifier(null);
  TalePage? get page => pageNotifier.value;
  set page(TalePage? value) => pageNotifier.value = value;

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, TalePage>(
      selector: selectedTalePageSelector,
      onInitialBuild: (dispatch, page) {
        pageNotifier.addListener(() {
          dispatch(SetIsTalePageEditedAction(newPage: pageNotifier.value));
        });
        safeInitialize(() {
          pageNotifier.value = page;
        });
      },
      builder: (context, dispatch, page) {
        return ValueListenableBuilder(
          valueListenable: pageNotifier,
          builder: (context, page, child) {
            if (page == null) {
              return const SizedBox();
            }
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
                      icon: Icons.delete_rounded,
                      // onPressed: () {},
                      //todo: onPressed
                    ),
                    const SizedBox(width: 8),
                    //Interactions Editor icon button
                    ButtonComponent.icon(
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
                    ButtonComponent.icon(
                      icon: Icons.remove_red_eye_rounded,
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => TalePreviewDialog(id: page.id),
                        );
                      },
                    ),
                    const SizedBox(width: 8),
                    StateConnector<AppState, bool>(
                      selector: isTalePageEditedSelector,
                      builder: (context, dispatch, isEdited) {
                        return ButtonComponent.icon(
                          icon: Icons.save_rounded,
                          onPressed: isEdited
                              ? () {
                                  dispatch(SaveTalePageAction(page));
                                }
                              : null,
                        );
                      },
                    ),
                    // const SizedBox(width: 8),
                    // ButtonComponent.iconOutlined(
                    //   icon: Icons.close_rounded,
                    //   onPressed: () {
                    //     dispatch(SelectEditorTalePageAction(null));
                    //   },
                    // ),
                  ],
                ),
                if (page.id.isNotEmpty) ...[
                  space(8),
                  Text('ID: ${page.id}', style: context.textTheme.titleMedium),
                ],
                space(16),
                TextFieldComponent(
                  label: 'Page Title',
                  initialValue: page.text,
                  onChanged: (value) {
                    if (page.text == value) {
                      return;
                    }
                    this.page = page.copyWith(text: value);
                  },
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
      },
    );
  }

  SizedBox space([num? space]) {
    return SizedBox(height: space?.toDouble() ?? 24);
  }
}
