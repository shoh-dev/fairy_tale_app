import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';

class TaleEditorSidebarComponent extends StatelessWidget {
  const TaleEditorSidebarComponent({
    super.key,
    required this.pages,
  });

  final List<TalePage> pages;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: context.height,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: StoreConnector<AppState, TalePage>(
            converter: (state) => state.state.taleEditorState.selectedPage,
            builder: (context, selectedPage) {
              return Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Pages", style: context.textTheme.titleLarge),
                  const Divider(height: 0),
                  //pages
                  for (var page in pages)
                    Builder(builder: (context) {
                      final bool isSelected = page == selectedPage;
                      return InkWell(
                        onTap: () {
                          if (isSelected) {
                            context.dispatch(SelectTaleEditorTalePageAction(null));
                            return;
                          }
                          context.dispatch(SelectTaleEditorTalePageAction(page));
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: isSelected ? context.colorScheme.primaryContainer : null,
                            border: isSelected
                                ? Border.all(
                                    color: context.colorScheme.onPrimaryContainer,
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: Column(
                            children: [
                              Image.network(
                                page.backgroundImage,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(context.taleTr(page.text)),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              );
            }),
      ),
    );
  }
}
