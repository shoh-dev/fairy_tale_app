import 'package:flutter/material.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class InteractionRightSidebarComponent extends StatelessWidget {
  const InteractionRightSidebarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: context.height,
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey)),
      ),
      // child: SingleChildScrollView(
      //   padding: EdgeInsets.all(Sizes.kLayoutPadding),
      //   child: StateConnector<AppState, List<TaleInteraction>>(
      //       selector: (state) => selectedTalePageSelector(state).interactions,
      //       builder: (context, dispatch, model) {
      //         if (selectedInteractions.isEmpty) {
      //           return Text(
      //             "Select an interaction to edit",
      //             style: context.textTheme.titleLarge,
      //           );
      //         }
      //         return InteractionDetailsForm(interactions: selectedInteractions);
      //       }),
      // ),
    );
  }
}
