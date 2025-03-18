import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class Translator extends StatelessWidget {
  const Translator({
    required this.toTranslate,
    required this.builder,
    this.showOriginalNotTranslated = true,
    super.key,
  });

  final List<String?> toTranslate;
  final Widget Function(List<String> translatedValue) builder;
  final bool showOriginalNotTranslated;

  @override
  Widget build(BuildContext context) {
    return StateConnector<AppState, (TaleLocalization, String)>(
      selector: (state) => (
        state.selectedTaleState.tale.localizations,
        state.applicationState.localizationState.locale,
      ),
      builder: (_, __, vm) {
        final locale = vm.$2;
        final translations = vm.$1.translations[locale];
        final translatedList = [
          for (final key in toTranslate)
            translations?[key] ??
                (showOriginalNotTranslated ? '$key' : '$key: NOT_FOUND'),
        ];
        return builder(translatedList);
      },
    );
  }
}
