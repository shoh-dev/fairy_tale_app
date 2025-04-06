import 'package:flutter/foundation.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_builder_flutter/features/tale/model/page.dart';

class TalePagesRepository extends Dependency {
  final SupabaseClient _client;

  const TalePagesRepository(SupabaseClient client) : _client = client;

  Future<Result<List<TalePageModel>>> getPages(String taleId) async {
    try {
      if (kDebugMode) {
        await Future.delayed(Duration(seconds: 1));
      }
      final response = await _client
          .from("pages")
          .select()
          .eq("tale_id", taleId);
      return Result.ok(response.map((e) => TalePageModel.fromJson(e)).toList());
    } catch (e) {
      return Result.error(e);
    }
  }
}
