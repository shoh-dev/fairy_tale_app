import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:myspace_data/src/models/result.dart';
import 'package:myspace_data/src/redux.dart';

class _Action extends DefaultAction {
  final Result? stateStatus;
  final int? localeVersion;
  final Map<String, String>? translations;
  final String? locale;

  // ignore: unused_element
  _Action({this.stateStatus, this.localeVersion, this.translations, this.locale});

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

// class SetApplicationLocaleAction extends DefaultAction {
//   final String locale;

//   SetApplicationLocaleAction(this.locale);

//   @override
//   AppState? reduce() {
//     return state.copyWith(applicationState: applicationState.copyWith(localizationState: localizationState.copyWith(locale: locale)));
//   }
// }

class GetTranslationsAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    dispatch(_Action(stateStatus: Result.loading()));
    await Future.delayed(const Duration(seconds: 2));
    final serverLocaleVersion = await applicationService.getLocaleVersion();
    await serverLocaleVersion.fold(
      (serverLocaleVersion) async {
        final appDir = await pathService.getApplicationDocumentsDirectory();
        await appDir.fold((dirOk) async {
          final localTrFile = File('${dirOk.path}/tr_${localizationState.locale}_$serverLocaleVersion.json');
          if (localTrFile.existsSync()) {
            log("Loading translations from local");
            final translations = mapTrFile(localTrFile);
            if (translations == null) {
              dispatch(_Action(stateStatus: Result.error(ErrorX('Error reading translations file'))));
            } else {
              dispatch(_Action(stateStatus: Result.ok(null), localeVersion: serverLocaleVersion, translations: translations));
            }
          } else {
            log("Loading translations from server");
            //do: get translations from server db
            final translations = await applicationService.getTranslationsFile(localizationState.locale, serverLocaleVersion);
            await translations.fold((trOk) async {
              //do: save translations to local db
              try {
                final trFile = File('${dirOk.path}/tr_${localizationState.locale}_$serverLocaleVersion.json');
                await trFile.writeAsBytes(trOk);
                final translations = mapTrFile(trFile);
                if (translations == null) {
                  dispatch(_Action(stateStatus: Result.error(ErrorX('Error reading translations file'))));
                } else {
                  log("Loaded new version of translations. Version:$serverLocaleVersion");
                  dispatch(_Action(stateStatus: Result.ok(null), localeVersion: serverLocaleVersion, translations: translations));
                }
              } catch (e, st) {
                dispatch(_Action(stateStatus: Result.error(ErrorX(e, st))));
              }
            }, (trE) {
              dispatch(_Action(stateStatus: Result.error(trE)));
            });
          }
        }, (dirE) {
          dispatch(_Action(stateStatus: Result.error(dirE)));
        });
      },
      (error) {
        dispatch(_Action(stateStatus: Result.error(error)));
      },
    );
    return null;
  }

  Map<String, String>? mapTrFile(File file) {
    try {
      final fileLocal = file.readAsStringSync();
      final Map<String, dynamic> json = jsonDecode(fileLocal);
      return json.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      return null;
    }
  }

  @override
  Object? wrapError(Object error, StackTrace stackTrace) {
    log(error.toString());
    return super.wrapError(error, stackTrace);
  }
}
