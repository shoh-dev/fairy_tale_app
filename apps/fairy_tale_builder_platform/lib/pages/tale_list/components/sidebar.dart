import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TaleListSidebarComponent extends StatelessWidget {
  const TaleListSidebarComponent({super.key});

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          ...ListTile.divideTiles(
            context: context,
            tiles: [
              //create new tale
              ListTile(
                leading: const Icon(Icons.add_rounded),
                title: const Text('Create new tale'),
                onTap: () {
                  // Navigator.of(context).push(
                  // MaterialPageRoute(
                  // builder: (context) => const TaleEditorPage()),//todo:
                  // );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
