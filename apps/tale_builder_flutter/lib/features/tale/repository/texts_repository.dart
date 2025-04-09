import 'package:myspace_core/myspace_core.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_builder_flutter/features/tale/model/text.dart';

class TalePageTextsRepository extends Dependency {
  final SupabaseClient _client;

  const TalePageTextsRepository(SupabaseClient client) : _client = client;

  Future<Result<List<TalePageTextModel>>> getTexts(String taleId) async {
    try {
      final response = await _client
          .from("texts")
          .select()
          .eq("tale_id", taleId);
      return Result.ok(
        response.map((e) => TalePageTextModel.fromJson(e)).toList(),
      );
    } catch (e) {
      return Result.error(e);
    }
  }
}
