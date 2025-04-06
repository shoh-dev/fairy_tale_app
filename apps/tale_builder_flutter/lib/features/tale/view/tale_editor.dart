import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view/components/orientation_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/components/page_number_selector.dart';
import 'package:tale_builder_flutter/features/tale/view/components/translation_selector.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class TaleEditor extends StatefulWidget {
  const TaleEditor({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  State<TaleEditor> createState() => _TaleEditorState();
}

class _TaleEditorState extends State<TaleEditor> {
  TaleViewModel get vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return LayoutComponent.row(
      spacing: 16,
      children: [
        //Left Sidebar: shows list of pages and add page at the bottom
        Expanded(flex: 1, child: _LeftBar(vm: vm)),

        const VerticalDivider(),

        //Body: shows selected page info, where user can align text or objects
        Expanded(flex: 3, child: _Body()),

        const VerticalDivider(),

        //Right Sidebar: if page is selected, shows page form, else shows tale form
        Expanded(flex: 1, child: _RightBar(vm: vm)),
      ],
    );
  }
}

class _LeftBar extends StatefulWidget {
  const _LeftBar({required this.vm});

  final TaleViewModel vm;

  @override
  State<_LeftBar> createState() => __LeftBarState();
}

class __LeftBarState extends State<_LeftBar> {
  TaleViewModel get vm => widget.vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      child: CommandWrapper(
        command: vm.fetchPagesCommand,
        okBuilder: (context, child) => child!,
        child: VmProvider(
          vm: vm,
          builder: (context, child) {
            final pages = vm.pages;
            final selectedPage = vm.selectedPage;
            return LayoutComponent.column(
              children: [
                RepaintBoundary(
                  child: LayoutComponent.row(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.book_outlined, size: 18),
                      TextComponent.any(
                        'Pages',
                        style: context.textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: context.height * .82,
                  child: ListView(
                    padding: EdgeInsets.only(right: 8),
                    children: [
                      //pages list
                      for (final page in pages)
                        Builder(
                          builder: (context) {
                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: context.borderRadius,
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: context.borderRadius,
                                ),
                                selected: selectedPage?.id == page.id,
                                selectedTileColor: context.colorScheme.primary,
                                selectedColor: context.colorScheme.onPrimary,
                                title: Text("Page ${page.pageNumber}"),
                                onTap: () {
                                  vm.onSelectPage(page);
                                },
                                trailing: ButtonComponent.icon(
                                  icon: Icons.delete_outlined,
                                  onPressed: () {
                                    vm.onDeletePage(page.id);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                const Divider(),
                //add page button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ButtonComponent.outlined(
                    text: 'Add Page',
                    icon: Icons.add_outlined,
                    onPressed: vm.onAddPage,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Container(height: context.height, color: Colors.white);
  }
}

class _RightBar extends StatefulWidget {
  const _RightBar({required this.vm});

  final TaleViewModel vm;

  @override
  State<_RightBar> createState() => __RightBarState();
}

class __RightBarState extends State<_RightBar> {
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
            final selectedPage = vm.selectedPage;
            return LayoutComponent.column(
              mainAxisSize: MainAxisSize.min,
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
                const Divider(),
                if (selectedPage != null)
                  LayoutComponent.column(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Page Fields
                      PageNumberSelector(
                        totalPages: vm.pages.length,
                        value: selectedPage.pageNumber,
                        onSelected: vm.onChangePageNumber,
                      ),
                    ],
                  )
                else
                  LayoutComponent.column(
                    spacing: 16,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Tale Fields
                      TranslationSelector(
                        label: "Title",
                        translations: loc.defaultTranslations,
                        value: tale.title,
                        onSelected: vm.onChangeTaleTitle,
                      ),
                      TranslationSelector(
                        label: "Description",
                        translations: loc.defaultTranslations,
                        value: tale.description,
                        onSelected: vm.onChangeTaleDescription,
                      ),
                      OrientationSelector(
                        value: tale.orientation,
                        onSelected: vm.onChangeTaleOrientation,
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
