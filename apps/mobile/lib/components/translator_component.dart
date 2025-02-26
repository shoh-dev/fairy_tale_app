import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';

class Translator extends StatelessWidget {
  const Translator({
    super.key,
    required this.toTranslate,
    required this.builder,
  });

  final List<String?> toTranslate;
  final Widget Function(List<String> translatedValue) builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<LocalizationState>(
      rebuildOnChange: false,
      isDistinct: false,
      converter: (state) => state.applicationState.localizationState,
      builder: (context, dispatch, vm) {
        log('TRANSLATOR COMPONENT IS REBUILDING');
        return vm.status.when(
          ok: () {
            final translatedList = [
              for (final key in toTranslate) vm.translations[key] ?? "$key: not_found",
            ];
            return builder(translatedList);
          },
          error: (error) {
            return builder([
              for (final key in toTranslate) "$key: ${error.toString()}",
            ]);
          },
          loading: () {
            return builder([
              for (final key in toTranslate) "$key: loading...",
            ]); //todo: check if this is correct
          },
        );
      },
    );
  }
}
