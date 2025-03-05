import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LocaleRepository {
  ResultFuture<int> getLocaleVersion(String locale);
  ResultFuture<Uint8List> getTranslationsFile(String locale, int version);
  ResultFuture<void> updateLocaleVersion({
    required String locale,
    required int version,
  });
  ResultFuture<void> uploadNewTranslations({
    required Map<String, String> translations,
    required int version,
    required String locale,
  });
}

class LocaleRepositoryImpl implements LocaleRepository {
  final SupabaseClient _supabase;

  const LocaleRepositoryImpl(this._supabase);

  @override
  ResultFuture<int> getLocaleVersion(String locale) async {
    try {
      final response = await _supabase
          .from('localization')
          .select('version')
          .eq('locale', locale)
          .single();
      return Result.ok(response['version'] as int);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<Uint8List> getTranslationsFile(
    String locale,
    int version,
  ) async {
    try {
      final response = await _supabase.storage
          .from('default')
          .download('localizations/$locale/$version.json');
      return Result.ok(response);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> updateLocaleVersion({
    required String locale,
    required int version,
  }) async {
    try {
      await _supabase.from('localization').update({
        'version': version,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('locale', locale);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> uploadNewTranslations({
    required Map<String, String> translations,
    required int version,
    required String locale,
  }) async {
    try {
      await _supabase.storage.from('default').uploadBinary(
            'localizations/$locale/$version.json',
            Uint8List.fromList(utf8.encode(jsonEncode(translations))),
          );
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }
}
