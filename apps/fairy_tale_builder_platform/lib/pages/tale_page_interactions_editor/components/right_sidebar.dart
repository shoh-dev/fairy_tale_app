import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_page_interactions_editor/components/interaction_details_form.dart';
import 'package:fairy_tale_builder_platform/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class InteractionRightSidebarComponent extends StatelessWidget {
  const InteractionRightSidebarComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.kLeftSidebarWidth,
      height: context.height,
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.kLayoutPadding),
        child: StateConnector<AppState, TaleInteraction>(
          selector: (state) =>
              state.taleListState.taleState.editorState.selectedInteraction,
          builder: (context, dispatch, model) {
            if (model.id.isEmpty) {
              return Text(
                'Select an interaction to edit',
                style: context.textTheme.titleLarge,
              );
            }
            return InteractionDetailsForm(interaction: model);
          },
        ),
      ),
    );
  }
}
