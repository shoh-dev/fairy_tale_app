import 'package:flutter/material.dart';
import 'package:mobile/features/tale_list/selected_tale/page.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TaleListPage extends StatelessWidget {
  const TaleListPage({super.key});

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
    return ResultStoreConnector(
      converter: (state) => state.taleListState.taleListResult,
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
        );
      },
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<List<Tale>>(
        converter: (state) => state.taleListState.taleList,
        builder: (context, dispatch, taleList) {
          return ListView.builder(
            itemCount: taleList.length,
            itemBuilder: (context, index) {
              final tale = taleList[index];
              return ListTile(
                leading: Image.network(
                  tale.coverImage,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(),
                ),
                title: TextComponent.any(context.taleTr(tale.title)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SelectedTalePage(taleId: tale.id),
                    ),
                  );
                },
                subtitle: TextComponent.any(
                  context.taleTr(tale.description),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        });
  }
}
