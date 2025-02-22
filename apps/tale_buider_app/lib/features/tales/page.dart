import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

class TalesPage extends StatelessWidget {
  const TalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Tale>>(
      converter: (store) => store.state.talesState.tales,
      builder: (context, vm) {
        return const SizedBox();
      },
    );
  }
}
