import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TaleService {
  ResultFuture<Tale> getTaleById(String taleId);
  ResultFuture<List<Tale>> getAllTales();
}

class TaleServiceImpl implements TaleService {
  final SupabaseClient _supabase;

  const TaleServiceImpl(this._supabase);

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
  ResultFuture<List<Tale>> getAllTales() async {
    try {
      final response = await _supabase.from('tales').select('''*, tale_pages(*, tale_interactions(*))''');

      return Result.ok(response.map((e) {
        return Tale.fromJson(e);
      }).toList());
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
