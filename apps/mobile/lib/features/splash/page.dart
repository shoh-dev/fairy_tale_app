import 'package:flutter/material.dart';
import 'package:mobile/features/tale_list/page.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';
import 'package:myspace_design_system/utils/helpers/context.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResultStoreConnector(
          converter: (state) => state.applicationState.localizationState.status,
          onInitialBuild: (dispatch, viewModel) {
            dispatch(GetTranslationsAction());
          },
          builder: (context, result) {
            return result.when(
              ok: () {
                return const Center(child: _Loaded1());
              },
              error: (localizationError) {
                return Center(child: Text(localizationError.toString()));
              },
              loading: () {
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
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const TaleListPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
