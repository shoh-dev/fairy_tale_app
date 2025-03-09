import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';

class UpdateTaleTranslationsAction extends DefaultAction {
  final String locale;
  final Iterable<String> keys;
  final Iterable<String> values;

  UpdateTaleTranslationsAction({
    required this.locale,
    required this.keys,
    required this.values,
  });

  @override
  Future<AppState?> reduce() async {
    final tale = taleState.tale;

    final newTranslations = Map.of(tale.localizations.translations);
    newTranslations[locale] = Map<String, String>.fromIterables(keys, values);

    dispatch(UpdateTaleAction(translations: newTranslations));
    return null;
  }
}
