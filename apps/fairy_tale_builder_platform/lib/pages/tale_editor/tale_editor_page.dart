import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/components/left_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class TaleEditorPage extends StatelessWidget {
  const TaleEditorPage({
    super.key,
    this.taleId = '',
  });

  final String taleId;

  @override
  Widget build(BuildContext context) {
    return StateResultConnector<AppState>(
      selector: (state) => state.taleListState.taleState.selectedTaleResult,
      onInitialBuild: (dispatch, model) {
        dispatch(GetTaleAction(taleId: taleId));
      },
      onDispose: (dispatch) {
        dispatch(GetTaleAction(reset: true));
        // dispatch(SelectEditorTalePageAction(null));//todo:
      },
      builder: (context, dispatch, model) {
        return model.when(
          ok: () {
            return const _Layout();
          },
          error: (error) {
            return Scaffold(
              body: Center(
                child: Text(error.toString()),
              ),
            );
          },
          loading: () {
            return const Scaffold(
              body: LoadingComponent(),
            );
          },
          initial: () {
            return const SizedBox();
          },
        );
      },
    );
  }
}

class _Layout extends StatelessWidget {
  const _Layout();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, Tale>(
      selector: (state) => state.taleListState.taleState.selectedTale,
      builder: (context, dispatch, tale) {
        return DefaultLayout(
          title: tale.id.isEmpty
              ? const Text('Create Tale')
              : const Text('Update Tale'),
          leftSidebar: TaleEditorLeftSidebarComponent(pages: tale.talePages),
          // rigthSidebar: TaleEditorRightSidebarComponent(tale: tale),
          // body: StateConnector<AppState, TalePage>(
          //   selector: (state) => state.taleEditorState.selectedPage,
          //   builder: (context, selectedPage) {
          //     final bool isSelected = selectedPage.id.isNotEmpty;
          //     if (isSelected) {
          //       //show page editor details
          //       return TalePageDetailsForm(page: selectedPage);
          //     }
          //     return Center(
          //       child: Text(
          //         'Select a page to edit',
          //         style: context.textTheme.titleLarge,
          //       ),
          //     );
          //   },
          // ),
          body: const Text('Not Implement!'),
        );
      },
    );
  }
}
