import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class LeftBar extends StatefulWidget {
  const LeftBar({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  State<LeftBar> createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> {
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
