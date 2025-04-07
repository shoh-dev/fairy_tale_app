import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/orientation_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/components/page_number_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/components/translation_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/tale_view.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class RightBar extends StatefulWidget {
  const RightBar({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  State<RightBar> createState() => _RightBarState();
}

class _RightBarState extends State<RightBar> {
  TaleViewModel get vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return CommandWrapper(
      command: vm.fetchTaleCommand,
      okBuilder: (BuildContext context, Widget? child) => child!,
      child: SizedBox(
        height: context.height,
        child: VmProvider(
          vm: vm,
          builder: (context, child) {
            final tale = vm.tale;
            final loc = vm.localization;
            final page = vm.selectedPage;
            final text = vm.selectedText;
            final deviceSize = Sizes.deviceSize(tale.isPortrait);
            return ListView(
              children: [
                RepaintBoundary(
                  child: LayoutComponent.row(
                    spacing: 4,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.settings_outlined, size: 18),
                      TextComponent.any(
                        'Properties',
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ExpansionTile(
                  childrenPadding: EdgeInsets.all(8),
                  title: RepaintBoundary(
                    child: LayoutComponent.row(
                      spacing: 4,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.book_outlined, size: 18),
                        TextComponent.any(
                          'Tale',
                          style: context.textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  children: [
                    //Tale Fields
                    TranslationSelector(
                      label: "Title",
                      translations: loc.defaultTranslations,
                      value: tale.title,
                      onSelected: vm.onChangeTaleTitle,
                    ),
                    const SizedBox(height: 16),
                    TranslationSelector(
                      label: "Description",
                      translations: loc.defaultTranslations,
                      value: tale.description,
                      onSelected: vm.onChangeTaleDescription,
                    ),
                    const SizedBox(height: 16),
                    OrientationSelector(
                      value: tale.orientation,
                      onSelected: vm.onChangeTaleOrientation,
                    ),
                  ],
                ),

                // const Divider(),
                if (page != null) ...[
                  const SizedBox(height: 16),
                  ExpansionTile(
                    childrenPadding: EdgeInsets.all(8),
                    title: RepaintBoundary(
                      child: LayoutComponent.row(
                        spacing: 4,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.pages_rounded, size: 18),
                          TextComponent.any(
                            'Page',
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    children: [
                      //Page Fields
                      PageNumberSelector(
                        totalPages: vm.pages.length,
                        value: page.pageNumber,
                        onSelected: vm.onChangePageNumber,
                      ),
                    ],
                  ),
                ],
                if (text != null) ...[
                  const SizedBox(height: 16),
                  ExpansionTile(
                    childrenPadding: EdgeInsets.all(8),
                    title: RepaintBoundary(
                      child: LayoutComponent.row(
                        spacing: 4,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.text_fields_outlined, size: 18),
                          TextComponent.any(
                            'Text',
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    children: [
                      //Text Fields
                      TranslationSelector(
                        label: "Text",
                        translations: loc.defaultTranslations,
                        value: text.text,
                        onSelected: vm.onChangeTextText,
                      ),
                      const SizedBox(height: 16),
                      SliderComponent(
                        label: "Width",
                        min: 1,
                        max: deviceSize.width - text.dx,
                        initialValue: text.width,
                        onChanged: (value) {
                          vm.onChangeTextSize(value, null);
                        },
                      ),
                      const SizedBox(height: 16),
                      SliderComponent(
                        label: "Height",
                        min: 1,
                        max: deviceSize.height - text.dy,
                        initialValue: text.height,
                        onChanged: (value) {
                          vm.onChangeTextSize(null, value);
                        },
                      ),
                      const SizedBox(height: 16),
                      SliderComponent(
                        label: "X Postion",
                        min: 0,
                        max: deviceSize.width - text.width,
                        initialValue: text.dx,
                        onChanged: (value) {
                          vm.onChangeTextPosition(value, null);
                        },
                      ),
                      const SizedBox(height: 16),
                      SliderComponent(
                        label: "Y Position",
                        min: 0,
                        max: deviceSize.height - text.height,
                        initialValue: text.dy,
                        onChanged: (value) {
                          vm.onChangeTextPosition(null, value);
                        },
                      ),

                      SliderComponent(
                        label: "Font Size",
                        min: 12,
                        max: 40,
                        initialValue: text.style?.fontSize,
                        onChanged: (value) {
                          if (value == null) return;
                          vm.onChangeTextFontSize(value);
                        },
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
