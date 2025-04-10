import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
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
  String locale = 'en';
  late TaleLocalizationModel localization;
  UnmodifiableMapView<String, String> get translations =>
      UnmodifiableMapView(localization.translations[locale]!);
  UnmodifiableListView<MapEntry<String, String>> get translationEntries =>
      UnmodifiableListView(translations.entries);

  final json = <TextEditingController, TextEditingController>{};
  Map<String, String> get jsonString => {
    for (final j in json.entries) j.key.text: j.value.text,
  };

  bool get isChanged =>
      !mapEquals(HashMap.of(translations), HashMap.of(jsonString));

  void _setJson() {
    json.forEach((key, value) {
      key.dispose();
      value.dispose();
    });
    json.clear();
    for (final entry in translationEntries) {
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
        locale = localization.defaultLocale;
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

  void onSelectLocale(String locale) {
    PromptDialog.show(
      "This action cannot be undon!",
      title: 'Changing locale will remove any unsaved changes! ',
      onLeftClick: (close) {
        close();
      },
      onRightClick: (close) {
        this.locale = locale;
        _setJson();
        notifyListeners();
        close();
      },
    );
  }

  void onAddNewTranslationEntry() {
    json.addAll({TextEditingController(): TextEditingController()});
    notifyListeners();
  }

  Future<bool> onSave() async {
    final newTranslations = Map.of(localization.translations);
    newTranslations[locale] = jsonString;
    localization = localization.copyWith(translations: newTranslations);
    final result = await _localizationRepository.updateLocalizations(
      localization,
    );
    switch (result) {
      case ResultOk<TaleLocalizationModel>():
        SuccessDialog.show("Saved successfully");
        return true;
      case ResultError<TaleLocalizationModel>():
        ErrorDialog.show(result.toString());
        return false;
    }
  }
}
