import 'package:fairy_tale_builder_platform/components/loading_component.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/pages/tale_list/tale_list_page.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_design_system/myspace_design_system.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(
          body: StateResultConnector<AppState>(
            selector: (state) =>
                state.applicationState.localizationState.status,
            onInitialBuild: (dispatch, model) {
              dispatch(GetTranslationsAction());
            },
            builder: (context, dispatch, model) {
              return model.when(
                ok: () {
                  return const Center(child: _Loaded());
                },
                error: (e) {
                  return Center(child: Text(e.toString()));
                },
                loading: () {
                  return const LoadingComponent();
                },
                initial: () {
                  return const SizedBox();
                },
              );
            },
          ),
        );
      },
    );
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (context) => const TalesPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
