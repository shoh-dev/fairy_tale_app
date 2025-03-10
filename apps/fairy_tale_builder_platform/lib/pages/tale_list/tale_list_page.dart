import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/components/translator_component.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/tale_list_state/tale_list_action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/tale_list_state/tale_list_state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_editor/tale_editor_page.dart';
import 'package:fairy_tale_builder_platform/pages/tale_list/components/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class TalesPage extends StatelessWidget {
  const TalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      leftSidebar: const TaleListSidebarComponent(),
      title: const Text('Tales'),
      body: StateConnector<AppState, TaleListState>(
        selector: (state) => state.taleListState,
        onInitialBuild: (dispatch, model) {
          dispatch(GetTaleListAction());
        },
        builder: (context, dispatch, vm) {
          return vm.listResult.when(
            ok: () {
              return _Grid(tales: vm.list);
            },
            error: (e) {
              return Center(child: Text(e.toString()));
            },
            loading: () {
              return const LoadingComponent();
            },
            initial: () {
              return const SizedBox();
            },
          );
        },
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.tales});

  final List<Tale> tales;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: tales.length,
      itemBuilder: (context, index) {
        final tale = tales[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => TaleEditorPage(taleId: tale.id),
              ),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: tale.coverImage.isEmpty
                      ? const Placeholder()
                      : Image.network(
                          //
                          // ignore: lines_longer_than_80_chars
                          '${tale.coverImage}?${DateTime.now().millisecondsSinceEpoch}',
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Translator(
                    toTranslate: [tale.title],
                    builder: (translatedValue) => Text(translatedValue[0]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
