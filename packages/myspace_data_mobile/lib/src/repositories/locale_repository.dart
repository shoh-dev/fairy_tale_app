import 'package:flutter/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LocaleRepository {
  ResultFuture<int> getLocaleVersion();
  ResultFuture<Uint8List> getTranslationsFile(String locale, int version);
}

class LocaleRepositoryImpl implements LocaleRepository {
  final SupabaseClient _supabase;

  const LocaleRepositoryImpl(this._supabase);

  @override
  ResultFuture<int> getLocaleVersion() async {
    try {
      final response = await _supabase.from('application').select('locale_version').single();
      return Result.ok(response['locale_version'] as int);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  @override
  ResultFuture<Uint8List> getTranslationsFile(String locale, int version) async {
    try {
      final response = await _supabase.storage.from("default").download("localizations/tr_${locale}_$version.json");
      return Result.ok(response);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
