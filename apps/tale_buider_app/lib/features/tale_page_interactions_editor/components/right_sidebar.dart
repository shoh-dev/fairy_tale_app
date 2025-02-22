import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';
import 'package:myspace_design_system/utils/sizes.dart';

class InteractionRightSidebarComponent extends StatelessWidget {
  const InteractionRightSidebarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: context.height,
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey)),
      ),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(Sizes.web.kLayoutPadding),
        child: StoreConnector<List<TaleInteraction>>(
            converter: (store) => store.state.taleEditorState.selectedInteractions,
            builder: (context, selectedInteractions) {
              if (selectedInteractions.isEmpty) {
                return Text(
                  "Select an interaction to edit",
                  style: context.textTheme.titleLarge,
                );
              }
              return const Column(
                spacing: 16,
                children: [
                  //todo: come up with something to use left sidebar
                ],
              );
            }),
      ),
    );
  }
}
