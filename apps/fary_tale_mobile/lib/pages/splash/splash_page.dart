import 'package:fairy_tale_mobile/pages/tale_list/tale_list_page.dart';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateResultConnector<AppState>(
        selector: (state) => state.applicationState.localizationState.status,
        onInitialBuild: (dispatch, viewModel) {
          dispatch(GetTranslationsAction());
        },
        builder: (context, dispatch, result) {
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
            initial: () {
              return const SizedBox();
            },
          );
        },
      ),
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const TaleListPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
