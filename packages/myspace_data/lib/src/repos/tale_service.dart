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

      final tale = Tale.fromJson(response);

      final pages = tale.talePages.map((page) {
        final interactions = page.taleInteractions.map((interaction) {
          return interaction.copyWith(currentPosition: interaction.initialPosition);
        }).toList();
        return page.copyWith(taleInteractions: interactions);
      });

      return Result.ok(tale.copyWith(talePages: pages.toList()));
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
