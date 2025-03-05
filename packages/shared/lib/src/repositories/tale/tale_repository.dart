import 'package:myspace_data/myspace_data.dart';
import 'package:shared/src/repositories/tale/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TaleRepository {
  ResultFuture<List<Tale>> getAllTales();
  ResultFuture<Tale> getTaleById(String taleId);
  ResultFuture<void> saveTaleLocalization({
    required String taleId,
    required Map<String, Map<String, String>> translations,
    required String defaultLocale,
  });
}

class TaleRepositoryImpl implements TaleRepository {
  final SupabaseClient _supabase;

  const TaleRepositoryImpl(this._supabase);

  @override
  ResultFuture<List<Tale>> getAllTales() async {
    try {
      final response = await _supabase
          .from('tales')
          .select('id, title, description, cover_image');

      return Result.ok(response.map(Tale.fromJson).toList());
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<Tale> getTaleById(String taleId) async {
    try {
      final response = await _supabase
          .from('tales')
          .select('*, pages(*, interactions(*)), localizations(*)')
          .eq('id', taleId)
          .single();

      return Result.ok(Tale.fromJson(response));
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> saveTaleLocalization({
    required String taleId,
    required Map<String, Map<String, String>> translations,
    required String defaultLocale,
  }) async {
    try {
      await _supabase.from('localizations').update({
        'translations': translations,
        'default_locale': defaultLocale,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('tale_id', taleId);

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }
}
