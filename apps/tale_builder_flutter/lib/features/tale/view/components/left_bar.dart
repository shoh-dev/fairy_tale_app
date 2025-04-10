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
                for (final page in pages) ...[
                  Builder(
                    builder: (context) {
                      final texts = vm.texts.where(
                        (element) => element.pageId == page.id,
                      );
                      return ExpansionTile(
                        title: ListTile(
                          dense: true,
                          selected: selectedPage?.id == page.id,
                          shape: RoundedRectangleBorder(
                            borderRadius: context.borderRadius,
                          ),
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
                        childrenPadding: EdgeInsets.all(8),
                        children: [
                          if (texts.isEmpty)
                            Center(
                              child: ButtonComponent.outlined(
                                text: "No text. Add one.",
                                icon: Icons.add,
                                onPressed: vm.onAddText,
                              ),
                            ),
                          for (int i = 0; i < texts.length; i++)
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Builder(
                                  builder: (context) {
                                    final text = texts.elementAt(i);
                                    final isSelected =
                                        vm.selectedTextId == text.id;
                                    return ListTile(
                                      dense: true,
                                      selected: isSelected,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: context.borderRadius,
                                        side: BorderSide(
                                          color: context.colorScheme.outline
                                              .withAlpha(100),
                                        ),
                                      ),
                                      selectedTileColor:
                                          context.colorScheme.primaryContainer,
                                      selectedColor:
                                          context
                                              .colorScheme
                                              .onPrimaryContainer,
                                      title: Text(
                                        "Text ${i + 1}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(text.text),
                                      onTap: () {
                                        vm.onSelectText(text);
                                      },
                                      trailing: ButtonComponent.icon(
                                        icon: Icons.delete_outlined,
                                        onPressed: () {
                                          vm.onDeleteText(text.id);
                                        },
                                      ),
                                    );
                                  },
                                ),
                                if (i < texts.length - 1)
                                  const SizedBox(height: 8),
                              ],
                            ),
                        ],
                      );

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
                  const SizedBox(height: 8),
                ],
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
