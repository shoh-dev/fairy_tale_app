import 'package:fairy_tale_builder_platform/components/translator_component.dart';
import 'package:fairy_tale_builder_platform/layout/default_layout.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
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
          return vm.taleListResult.when(
            ok: () {
              return _Grid(tales: vm.taleList);
            },
            error: (e) {
              return Center(child: Text(e.toString()));
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
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
            // Navigator.of(context).push(
            // MaterialPageRoute(
            // builder: (context) => TaleEditorPage(taleId: tale.id)),//todo:
            // );
          },
          borderRadius: BorderRadius.circular(8),
          child: Card(
            child: Column(
              children: [
                Expanded(
                  child: Image.network(
                    tale.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
