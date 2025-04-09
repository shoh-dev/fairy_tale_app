import 'package:flutter/foundation.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_builder_flutter/features/tale/model/localization.dart';

class TaleLocalizationRepository extends Dependency {
  final SupabaseClient _client;

  const TaleLocalizationRepository(SupabaseClient client) : _client = client;

  Future<Result<TaleLocalizationModel>> getLocalization(String taleId) async {
    try {
      final response =
          await _client
              .from("localizations")
              .select()
              .eq("tale_id", taleId)
              .single();
      return Result.ok(TaleLocalizationModel.fromJson(response));
    } catch (e) {
      return Result.error(e);
    }
  }
}
