import 'package:flutter/foundation.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_builder_flutter/features/tale/model/tale.dart';

class TaleRepository extends Dependency {
  final SupabaseClient _client;

  const TaleRepository(SupabaseClient client) : _client = client;

  Future<Result<TaleModel>> getTale(String id) async {
    try {
      if (kDebugMode) {
        await Future.delayed(Duration(seconds: 1));
      }
      final response =
          await _client.from("/tales").select().eq("id", id).single();
      return Result.ok(TaleModel.fromJson(response));
    } catch (e) {
      return Result.error(e);
    }
  }
}
