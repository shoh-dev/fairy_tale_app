import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';

import 'state.dart';

class AppStoreProvider extends StatelessWidget {
  final Widget child;
  final Store<AppState> appStore;

  const AppStoreProvider({
    super.key,
    required this.appStore,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: appStore,
      child: child,
    );
  }
}
