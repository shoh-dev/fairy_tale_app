import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:tale_buider_app/features/tale_editor/components/sidebar.dart';
import 'package:tale_buider_app/features/tale_editor/components/tale_details_form.dart';
import 'package:tale_buider_app/layout/default_layout.dart';

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
        store.dispatch(GetTaleAction('', reset: true));
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
            leftSidebar: TaleEditorSidebarComponent(
              pages: tale.talePages,
            ),
            body: StoreConnector<TalePage>(
              converter: (store) => store.state.taleEditorState.selectedPage,
              builder: (context, selectedPage) {
                final bool isSelected = selectedPage.id.isNotEmpty;
                if (isSelected) {
                  //show page editor details
                  return const Text("Tale Page Details");
                }
                //show tale editor details
                return TaleDetailsForm(tale: tale);
              },
            ),
          );
        });
  }
}
