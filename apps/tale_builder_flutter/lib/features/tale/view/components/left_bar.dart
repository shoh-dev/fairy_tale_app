import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:tale_builder_flutter/features/tale/view_model/tale_view_model.dart';

class LeftBar extends StatelessWidget {
  const LeftBar({super.key, required this.vm});

  final TaleViewModel vm;

  @override
  Widget build(BuildContext context) {
    final pages = vm.pages;
    final selectedPage = vm.selectedPage;
    return SizedBox(
      height: context.height,
      child: LayoutComponent.column(
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(right: 8),
              children: [
                //pages list
                for (final page in pages)
                  Builder(
                    builder: (context) {
                      return Card(
                        elevation: 0,
                        color: context.colorScheme.surfaceContainerHighest,
                        shape: RoundedRectangleBorder(
                          borderRadius: context.borderRadius,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: context.borderRadius,
                          ),
                          selected: selectedPage?.id == page.id,
                          selectedTileColor:
                              context.colorScheme.primaryContainer,
                          selectedColor: context.colorScheme.onPrimaryContainer,
                          title: Text("Page ${page.pageNumber}"),
                          subtitle: Text(
                            page.id,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
          const Divider(),
          //add page button
          ButtonComponent.outlined(
            text: 'Add Page',
            icon: Icons.add_outlined,
            onPressed: vm.onAddPage,
          ).expanded(),
        ],
      ),
    );
  }
}
