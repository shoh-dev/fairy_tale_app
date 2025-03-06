import 'package:fairy_tale_builder_platform/components/translator_component.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/action.dart';
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
    return StateConnector<AppState, List<TalePage>>(
      selector: talePagesSelector,
      builder: (context, dispatch, pages) {
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
            child: StateConnector<AppState, TalePage>(
              selector: selectedTalePageSelector,
              builder: (context, dispatch, model) {
                return Column(
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
                          dispatch(AddNewTalePageAction());
                        },
                      ),
                    ),
                    const Divider(height: 0),
                    //pages
                    for (final page in pages)
                      StateConnector<AppState, bool>(
                        selector: (state) =>
                            isTalePageSelectedSelector(state, page),
                        builder: (context, dispatch, isSelected) {
                          return InkWell(
                            onTap: () {
                              dispatch(SelectEditorTalePageAction(page));
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              width: double.infinity,
                              height: 370,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? context.colorScheme.primaryContainer
                                    : null,
                                border: isSelected
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
                                      page.metadata.backgroundImageUrl,
                                      fit: BoxFit.cover,
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
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
