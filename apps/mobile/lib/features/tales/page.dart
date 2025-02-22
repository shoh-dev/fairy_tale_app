import 'package:flutter/material.dart';
import 'package:mobile/features/tales/pages/page.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class TalesPage extends StatelessWidget {
  const TalesPage({super.key});

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
    return StatusStatusWrapper(
      converter: (store) => store.state.talesState.status,
      onInitialBuild: (context, store, viewModel) {
        store.dispatch(GetAllTalesAction());
      },
      builder: (context, vm) {
        return vm.fold(
          () {
            return const _Loaded();
          },
          (e) => Center(
            child: Text(e.toString()),
          ),
          () {
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
        converter: (store) => store.state.talesState.tales,
        builder: (context, tales) {
          return ListView.builder(
            itemCount: tales.length,
            itemBuilder: (context, index) {
              final tale = tales[index];
              return ListTile(
                leading: Image.network(
                  tale.coverImage,
                  errorBuilder: (context, error, stackTrace) => const SizedBox(),
                ),
                title: TextComponent.any(context.taleTr(tale.title)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TalePagesPage(taleId: tale.id),
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
