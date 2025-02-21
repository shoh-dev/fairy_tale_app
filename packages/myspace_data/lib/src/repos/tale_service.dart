import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TaleService {
  ResultFuture<List<Tale>> getAllTales();
  ResultFuture<Tale> getTaleById(String taleId);
}

class TaleServiceImpl implements TaleService {
  final SupabaseClient _supabase;

  const TaleServiceImpl(this._supabase);

  @override
  ResultFuture<List<Tale>> getAllTales() async {
    try {
      final response = await _supabase.from('tales').select('id, title, description, cover_image');

      return Result.ok(response.map((e) => Tale.fromJson(e)).toList());
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  @override
  ResultFuture<Tale> getTaleById(String taleId) async {
    try {
      final response = await _supabase.from('tales').select('*, tale_pages(*, tale_interactions(*))').eq('id', taleId).maybeSingle();

      if (response == null) return Result.error(ErrorX("Tale not found"));

      return Result.ok(Tale.fromJson(response));
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
