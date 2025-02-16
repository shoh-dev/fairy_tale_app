import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_redux/myspace_redux.dart';

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
    return StoreConnector<AppState, Result<List<Tale>>>(
      // vm: () => _Factory(this),
      converter: (store) => store.state.talesState.tales,
      onInitialBuild: (context, store, viewModel) {
        store.dispatch(LoadAllTalesAction());
      },
      builder: (context, vm) {
        return vm.fold(
          (tales) {
            return ListView.builder(
              itemCount: tales.length,
              itemBuilder: (context, index) {
                final tale = tales[index];
                return ListTile(
                  leading: tale.coverImage.isNotEmpty ? Image.network(tale.coverImage) : null,
                  title: Text(tale.title),
                  subtitle: Text(tale.pages.length.toString()),
                );
              },
            );
          },
          (e) => Center(
            child: Text(e.toString()),
          ),
        );
      },
    );
  }
}

// class _Factory extends BaseFactory<_Tales, _Vm> {
//   _Factory(super.connector);

//   @override
//   _Vm fromStore() {
//     return _Vm(
//       tales: state.talesState.tales,
//     );
//   }
// }

// class _Vm extends Vm {
//   final Result<List<Tale>> tales;

//   _Vm({required this.tales});
// }
