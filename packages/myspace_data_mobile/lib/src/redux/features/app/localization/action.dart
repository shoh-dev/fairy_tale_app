import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';

class _Action extends DefaultAction {
  final StateResult? stateStatus;
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

class GetTranslationsAction extends DefaultAction {
  @override
  Future<AppState?> reduce() async {
    dispatch(_Action(stateStatus: StateResult.loading()));

    await Future.delayed(const Duration(seconds: 1));
    dispatch(_Action(stateStatus: StateResult.ok()));
    //todo: implement
    // final serverLocaleVersion = await applicationService.getLocaleVersion();
    // await serverLocaleVersion.fold(
    //   (serverLocaleVersion) async {
    //     final appDir = await pathService.getApplicationDocumentsDirectory();
    //     await appDir.fold(
    //       (dirOk) async {
    //         final localTrFile = File('${dirOk.path}/tr_${localizationState.locale}_$serverLocaleVersion.json');
    //         if (localTrFile.existsSync()) {
    //           log("Loading translations from local");
    //           final translations = _mapTrFile(localTrFile);
    //           if (translations == null) {
    //             dispatch(_Action(stateStatus: StateResult.error(ErrorX('Error reading translations file'))));
    //           } else {
    //             dispatch(_Action(stateStatus: StateResult.ok(), localeVersion: serverLocaleVersion, translations: translations));
    //           }
    //         } else {
    //           log("Loading translations from server");
    //           //do: get translations from server db
    //           final translations = await applicationService.getTranslationsFile(localizationState.locale, serverLocaleVersion);
    //           await translations.fold(
    //             (trOk) async {
    //               //do: save translations to local db
    //               try {
    //                 final trFile = File('${dirOk.path}/tr_${localizationState.locale}_$serverLocaleVersion.json');
    //                 await trFile.writeAsBytes(trOk);
    //                 final translations = _mapTrFile(trFile);
    //                 if (translations == null) {
    //                   dispatch(_Action(stateStatus: StateResult.error(ErrorX('Error reading translations file'))));
    //                 } else {
    //                   log("Loaded new version of translations. Version:$serverLocaleVersion");
    //                   dispatch(_Action(stateStatus: StateResult.ok(), localeVersion: serverLocaleVersion, translations: translations));
    //                 }
    //               } catch (e, st) {
    //                 dispatch(_Action(stateStatus: StateResult.error(ErrorX(e, st))));
    //               }
    //             },
    //             (trE) {
    //               dispatch(_Action(stateStatus: StateResult.error(trE)));
    //             },
    //           );
    //         }
    //       },
    //       (dirE) {
    //         dispatch(_Action(stateStatus: StateResult.error(dirE)));
    //       },
    //     );
    //   },
    //   (error) {
    //     dispatch(_Action(stateStatus: StateResult.error(error)));
    //   },
    // );
    return null;
  }

  Map<String, String>? _mapTrFile(File file) {
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
