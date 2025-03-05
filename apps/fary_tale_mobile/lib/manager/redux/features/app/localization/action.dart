import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:myspace_data/myspace_data.dart';

class _Action extends DefaultAction {
  _Action({
    this.stateStatus,
    this.localeVersion,
    this.translations,
    //
    // ignore: unused_element
    this.locale,
  });

  final StateResult? stateStatus;
  final int? localeVersion;
  final Map<String, String>? translations;
  final String? locale;

  @override
  AppState reduce() {
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
  @override
  Future<AppState?> reduce() async {
    dispatch(_Action(stateStatus: const StateResult.loading()));
    final serverLocaleVersion =
        await applicationRepository.getLocaleVersion(localizationState.locale);
    await serverLocaleVersion.when(
      ok: (serverLocaleVersion) async {
        final appDir = await pathService.getApplicationDocumentsDirectory();
        await appDir.when(
          ok: (dirOk) async {
            final localTrFile = File(
              '${dirOk.path}/${localizationState.locale}/$serverLocaleVersion.json',
            );
            if (localTrFile.existsSync()) {
              log('Loading translations from local');
              final translations = _mapTrFile(localTrFile);
              if (translations == null) {
                dispatch(
                  _Action(
                    stateStatus: const StateResult.error(
                      ErrorX('Error reading translations file'),
                    ),
                  ),
                );
              } else {
                dispatch(
                  _Action(
                    stateStatus: const StateResult.ok(),
                    localeVersion: serverLocaleVersion,
                    translations: translations,
                  ),
                );
              }
            } else {
              log('Loading translations from server');
              //do: get translations from server db
              final translations =
                  await applicationRepository.getTranslationsFile(
                localizationState.locale,
                serverLocaleVersion,
              );
              await translations.when(
                ok: (trOk) async {
                  //do: save translations to local db
                  try {
                    final trFile = File(
                      '${dirOk.path}/${localizationState.locale}/$serverLocaleVersion.json',
                    );
                    await trFile.writeAsBytes(trOk);
                    final translations = _mapTrFile(trFile);
                    if (translations == null) {
                      dispatch(
                        _Action(
                          stateStatus: const StateResult.error(
                            ErrorX('Error reading translations file'),
                          ),
                        ),
                      );
                    } else {
                      //
                      // ignore: lines_longer_than_80_chars
                      log('Loaded new version of translations. Version:$serverLocaleVersion');
                      dispatch(
                        _Action(
                          stateStatus: const StateResult.ok(),
                          localeVersion: serverLocaleVersion,
                          translations: translations,
                        ),
                      );
                    }
                  } catch (e, st) {
                    dispatch(
                      _Action(stateStatus: StateResult.fromException(e, st)),
                    );
                  }
                },
                error: (trE) {
                  dispatch(_Action(stateStatus: StateResult.error(trE)));
                },
              );
            }
          },
          error: (dirE) {
            dispatch(_Action(stateStatus: StateResult.error(dirE)));
          },
        );
      },
      error: (error) {
        dispatch(_Action(stateStatus: StateResult.error(error)));
      },
    );
    return null;
  }

  Map<String, String>? _mapTrFile(File file) {
    try {
      final fileLocal = file.readAsStringSync();
      final json = jsonDecode(fileLocal) as Map<String, dynamic>;
      return json.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      return null;
    }
  }
}
