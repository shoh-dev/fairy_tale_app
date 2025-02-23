import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/utils/helpers/theme.dart';
import 'package:tale_buider_app/features/tale_editor/components/right_sidebar.dart';
import 'package:tale_buider_app/features/tale_editor/components/left_sidebar.dart';
import 'package:tale_buider_app/layout/default_layout.dart';

import 'components/tale_page_details_form.dart';

class TaleEditorPage extends StatelessWidget {
  const TaleEditorPage({
    super.key,
    this.taleId,
  });

  final String? taleId;

  @override
  Widget build(BuildContext context) {
    return StatusStatusWrapper(
      converter: (store) => store.state.taleState.status,
      onInitialBuild: (context, store, viewModel) {
        if (taleId == null) {
          store.dispatch(SelectEmptyTaleAction());
        } else {
          store.dispatch(GetTaleAction(taleId!));
        }
      },
      onDispose: (store) {
        store.dispatchAll([
          GetTaleAction('', reset: true),
          SelectEditorTalePageAction(null),
        ]);
      },
      builder: (context, result) {
        return result.fold(
          () {
            return const _Layout();
          },
          (error) {
            return Scaffold(
              body: Center(
                child: Text(error.toString()),
              ),
            );
          },
          () {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
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
    return StoreConnector<Tale>(
        converter: (store) => store.state.taleState.selectedTale,
        builder: (context, tale) {
          return DefaultLayout(
            title: tale.id.isEmpty ? const Text("Create Tale") : const Text("Update Tale"),
            leftSidebar: TaleEditorLeftSidebarComponent(pages: tale.talePages),
            rigthSidebar: TaleEditorRightSidebarComponent(tale: tale),
            body: StoreConnector<TalePage>(
              converter: (store) => store.state.taleEditorState.selectedPage,
              builder: (context, selectedPage) {
                final bool isSelected = selectedPage.id.isNotEmpty;
                if (isSelected) {
                  //show page editor details
                  return TalePageDetailsForm(page: selectedPage);
                }
                return Center(
                  child: Text(
                    "Select a page to edit",
                    style: context.textTheme.titleLarge,
                  ),
                );
              },
            ),
          );
        });
  }
}
