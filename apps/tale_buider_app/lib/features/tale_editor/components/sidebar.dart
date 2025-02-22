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
        child: Column(
          spacing: 16,
          mainAxisSize: MainAxisSize.min,
          children: [
            //pages
            for (var page in pages)
              InkWell(
                onTap: () {
                  //todo:
                },
                borderRadius: BorderRadius.circular(8),
                child: Card(
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
              ),
          ],
        ),
      ),
    );
  }
}
