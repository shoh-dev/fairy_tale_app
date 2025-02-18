import 'dart:developer';

import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TaleService {
  ResultFuture<List<Tale>> getAllTales();
  ResultFuture<Tale> getTaleById(String taleId);
  ResultFuture<List<TaleLocalization>> getTaleLocalizations(String taleId, String appLanguage);
}

class TaleServiceImpl implements TaleService {
  final SupabaseClient _supabase;

  const TaleServiceImpl(this._supabase);

  @override
  ResultFuture<List<Tale>> getAllTales() async {
    try {
      final response = await _supabase.from('tales').select('id, title, description, language_code, cover_image');

      return Result.ok(response.map((e) => Tale.fromJson(e)).toList());
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  @override
  ResultFuture<Tale> getTaleById(String taleId) async {
    try {
      final response = await _supabase.from('tales').select('*, tale_pages(*, tale_interactions(*))').eq('id', taleId).maybeSingle();

      if (response == null) return ErrorX("Tale not found");

      return Result.ok(Tale.fromJson(response));
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  @override
  ResultFuture<List<TaleLocalization>> getTaleLocalizations(String taleId, String appLanguage) async {
    try {
      final response = await _supabase.from('tale_localizations').select('key, value').eq('tale_id', taleId).eq("language", appLanguage);

      return Result.ok(response.map((e) => TaleLocalization.fromJson(e)).toList());
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
