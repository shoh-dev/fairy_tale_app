import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';
import 'package:tale_buider_app/features/tales/page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: StatusStatusWrapper(
            converter: (store) => store.state.talesState.status,
            onInitialBuild: (context, store, viewModel) {
              store.dispatch(GetAllTalesAction());
            },
            builder: (context, status) {
              return status.fold(
                (localizationOk) {
                  return const Center(child: _Loaded());
                },
                (e) {
                  return Center(child: Text(e.toString()));
                },
                () {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              );
            }),
      );
    });
  }
}

class _Loaded extends StatefulWidget {
  const _Loaded();

  @override
  State<_Loaded> createState() => __LoadedState();
}

class __LoadedState extends State<_Loaded> with StateHelpers {
  @override
  void initState() {
    super.initState();
    safeInitialize(() {
      // move to tales list page
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TalesPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
