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
    final selectedTale = taleState.selectedTale;
    // final oldTranslations = Map.of(selectedTale.localizations.translations);
    final newTranslations = Map.of(selectedTale.localizations.translations);

    newTranslations[locale] = Map<String, String>.fromIterables(keys, values);

    //todo: check why this is not working
    // if (mapEquals(oldTranslations, newTranslations)) {
    //   return null;
    // }

    dispatch(UpdateTaleAction(translations: newTranslations));
    return null;
  }
}
