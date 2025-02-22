import 'package:flutter/material.dart';
import 'package:mobile/features/tales/page.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatusStatusWrapper(
          converter: (store) => store.state.applicationState.localizationState.status,
          onInitialBuild: (context, store, viewModel) {
            store.dispatch(GetTranslationsAction());
          },
          builder: (context, status) {
            return status.fold(
              () {
                return const Center(child: _Loaded1());
              },
              (localizationError) {
                return Center(child: Text(localizationError.toString()));
              },
              () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }),
    );
  }
}

class _Loaded1 extends StatefulWidget {
  const _Loaded1();

  @override
  State<_Loaded1> createState() => __Loaded1State();
}

class __Loaded1State extends State<_Loaded1> with StateHelpers {
  @override
  void initState() {
    super.initState();
    safeInitialize(() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TalesPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
