import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LocaleRepository {
  ResultFuture<int> getLocaleVersion(String locale);
  ResultFuture<Uint8List> getTranslationsFile(String locale, int version);
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
}
