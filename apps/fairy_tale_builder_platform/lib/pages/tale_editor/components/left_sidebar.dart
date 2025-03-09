import 'package:fairy_tale_builder_platform/components/translator_component.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/page_actions.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/selector.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TaleEditorLeftSidebarComponent extends StatelessWidget {
  const TaleEditorLeftSidebarComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: selectedTaleSelector,
      builder: (context, dispatch, tale) {
        return Container(
          width: Sizes.kLeftSidebarWidth,
          height: context.height,
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Sizes.kLayoutPadding),
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Pages', style: context.textTheme.titleLarge),
                SizedBox(
                  width: double.infinity,
                  child: ButtonComponent.outlined(
                    text: 'Add page',
                    icon: Icons.add_rounded,
                    onPressed: () {
                      dispatch(AddPageAction());
                    },
                  ),
                ),
                const Divider(height: 0),
                //pages
                for (final page in tale.pages)
                  StateConnector<AppState, bool>(
                    selector: (state) =>
                        isTalePageSelectedSelector(state, page),
                    builder: (context, dispatch, isSelected) {
                      final isPageValid = tale.isPageValid(page).isEmpty;
                      return InkWell(
                        onTap: () {
                          dispatch(SelectPageAction(page.id));
                        },
                        child: Badge(
                          isLabelVisible: page.isNew,
                          alignment: Alignment.topLeft,
                          label: const Text('New'),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: double.infinity,
                            height: 370,
                            decoration: BoxDecoration(
                              color: !isPageValid
                                  ? context.error.withAlpha(50)
                                  : isSelected
                                      ? context.colorScheme.primaryContainer
                                      : null,
                              border: !isPageValid
                                  ? Border.all(
                                      color: context.error,
                                      width: 2,
                                    )
                                  : isSelected
                                      ? Border.all(
                                          color: context
                                              .colorScheme.onPrimaryContainer,
                                          width: 2,
                                        )
                                      : null,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (page.metadata.hasBackgroundImage)
                                  Image.network(
                                    '${page.metadata.backgroundImageUrl}?${DateTime.now().millisecondsSinceEpoch}',
                                    fit: BoxFit.cover,
                                    height: 300,
                                  )
                                else
                                  Container(
                                    height: 300,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        //todo: no image placeholder
                                      ),
                                    ),
                                    child: const Placeholder(),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Translator(
                                    showOriginalNotTranslated: page.isNew,
                                    toTranslate: [page.text],
                                    builder: (translatedValue) {
                                      return SizedBox(
                                        width: 330,
                                        child: Text(
                                          translatedValue[0],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
