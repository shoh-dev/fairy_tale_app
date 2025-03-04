import 'package:fairy_tale_mobile/components/translator_component.dart';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/pages/tale_list/selected_tale/selected_tale_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';
import 'package:shared/shared.dart';

class TaleListPage extends StatelessWidget {
  const TaleListPage({super.key});

  static const route = '/tale_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tales'),
      ),
      body: const _Tales(),
    );
  }
}

class _Tales extends StatelessWidget {
  const _Tales();

  @override
  Widget build(BuildContext context) {
    return StateResultConnector<AppState>(
      selector: (state) => state.taleListState.taleListResult,
      onInitialBuild: (dispatch, viewModel) {
        dispatch(GetTaleListAction());
      },
      builder: (context, dispatch, result) {
        return result.when(
          ok: () {
            return const _Loaded();
          },
          error: (e) => Center(
            child: Text(e.toString()),
          ),
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
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

class _Loaded extends StatelessWidget {
  const _Loaded();

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, List<Tale>>(
      selector: (state) => state.taleListState.taleList,
      builder: (context, dispatch, taleList) {
        return RefreshIndicator.adaptive(
          onRefresh: () {
            dispatch(GetTaleListAction());
            return Future<void>.value();
          },
          child: ListView.builder(
            itemCount: taleList.length,
            itemBuilder: (context, index) {
              final tale = taleList[index];
              return Translator(
                toTranslate: [
                  tale.title,
                  tale.description,
                ],
                builder: (translatedValue) {
                  return ListTile(
                    leading: Image.network(
                      tale.coverImage,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(),
                    ),
                    title: TextComponent.any(translatedValue[0]),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) =>
                              SelectedTalePage(taleId: tale.id),
                        ),
                      );
                    },
                    subtitle: TextComponent.any(
                      translatedValue[1],
                      // maxLines: 2,
                      // overflow: TextOverflow.ellipsis,//todo:
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
