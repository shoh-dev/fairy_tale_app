import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_builder_flutter/features/tale/model/localization.dart';
import 'package:tale_builder_flutter/features/tale/repository/localization_repository.dart';

class TranslationsViewModel extends Vm {
  final TaleLocalizationRepository _localizationRepository;

  TranslationsViewModel({
    required TaleLocalizationRepository localizationRepository,

    required String id,
  }) : _localizationRepository = localizationRepository {
    localization = TaleLocalizationModel.empty(id);
    fetchLocalizationCommand = CommandParam(_fetchLocalization)..execute(id);
  }

  late final CommandParam<void, String> fetchLocalizationCommand;
  late TaleLocalizationModel localization;
  UnmodifiableMapView<String, String> get defaultTranslations =>
      UnmodifiableMapView(localization.defaultTranslations);
  UnmodifiableListView<MapEntry<String, String>>
  get defaultTranslationEntries =>
      UnmodifiableListView(defaultTranslations.entries);

  final json = <TextEditingController, TextEditingController>{};

  void _setJson() {
    json.forEach((key, value) {
      key.dispose();
      value.dispose();
    });
    json.clear();
    for (final entry in defaultTranslationEntries) {
      final keyController = TextEditingController(text: entry.key);
      final valueController = TextEditingController(text: entry.value);
      json.addAll({keyController: valueController});
    }
  }

  Future<Result<void>> _fetchLocalization(String id) async {
    final result = await _localizationRepository.getLocalization(id);
    switch (result) {
      case ResultOk<TaleLocalizationModel>():
        final value = result.value;
        localization = value;
        _setJson();
        log.info("Fetched localization");
        notifyListeners();
        return Result.ok(null);
      case ResultError<TaleLocalizationModel>():
        log.warning('Fetch localization error: ${result.e}');
        notifyListeners();
        return Result.error(result.e);
    }
  }

  void onRemoveEntry(int index) {
    if (index < 0 || index >= json.length) return;
    final keyController = json.keys.elementAt(index);
    final valueController = json[keyController]!;

    // Dispose controllers
    keyController.dispose();
    valueController.dispose();
    json.remove(keyController);

    notifyListeners();
  }
}
