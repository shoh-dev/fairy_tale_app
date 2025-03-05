import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:myspace_data/myspace_data.dart';

class _Action extends DefaultAction {
  _Action({
    this.stateStatus,
    this.localeVersion,
    this.translations,
    //
    // ignore: unused_element
    this.locale,
    this.for2 = false,
  });

  final StateResult? stateStatus;
  final int? localeVersion;
  final Map<String, String>? translations;
  final String? locale;
  final bool for2;

  @override
  AppState reduce() {
    if (for2) {
      return state.copyWith(
        applicationState: applicationState.copyWith(
          localizationState2: localizationState2.copyWith(
            status: stateStatus ?? localizationState2.status,
            localeVersion: localeVersion ?? localizationState2.localeVersion,
            translations: translations ?? localizationState2.translations,
            locale: locale ?? localizationState2.locale,
          ),
        ),
      );
    }
    return state.copyWith(
      applicationState: applicationState.copyWith(
        localizationState: localizationState.copyWith(
          status: stateStatus ?? localizationState.status,
          localeVersion: localeVersion ?? localizationState.localeVersion,
          translations: translations ?? localizationState.translations,
          locale: locale ?? localizationState.locale,
        ),
      ),
    );
  }
}

class GetTranslationsAction extends DefaultAction {
  final String? newLocale;
  final bool for2;

  GetTranslationsAction({
    this.newLocale,
    this.for2 = false,
  });

  @override
  Future<AppState?> reduce() async {
    dispatch(
      _Action(
        for2: for2,
        locale: newLocale,
        stateStatus: const StateResult.loading(),
      ),
    );
    final locale = newLocale ?? localizationState.locale;
    final serverLocaleVersion =
        await applicationRepository.getLocaleVersion(locale);
    await serverLocaleVersion.when(
      ok: (serverLocaleVersion) async {
        log('Loading translations from server');
        //do: get translations from server db
        final translations = await applicationRepository.getTranslationsFile(
          locale,
          serverLocaleVersion,
        );
        await translations.when(
          ok: (trOk) async {
            //do: save translations to local db
            try {
              //trOk is a byte array
              //convert to json without using File
              final json =
                  jsonDecode(utf8.decode(trOk)) as Map<String, dynamic>;

              //
              // ignore: lines_longer_than_80_chars
              log('Loaded translations for $locale. Version:$serverLocaleVersion');
              dispatch(
                _Action(
                  for2: for2,
                  stateStatus: const StateResult.ok(),
                  localeVersion: serverLocaleVersion,
                  translations:
                      json.map((key, value) => MapEntry(key, value.toString())),
                ),
              );
            } catch (e, st) {
              dispatch(
                _Action(
                    for2: for2, stateStatus: StateResult.fromException(e, st)),
              );
            }
          },
          error: (trE) {
            dispatch(_Action(for2: for2, stateStatus: StateResult.error(trE)));
          },
        );
      },
      error: (ErrorX error) {
        dispatch(_Action(for2: for2, stateStatus: StateResult.error(error)));
      },
    );
    return null;
  }
}
