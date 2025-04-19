import 'package:myspace_core/myspace_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_mobile_flutter/features/tale/model/tale.dart';

class TaleRepository extends Dependency {
  final SupabaseClient _client;

  const TaleRepository(SupabaseClient client) : _client = client;

  Future<Result<List<TaleModel>>> getMyTales({String query = ''}) async {
    try {
      var response = _client.from("tales").select(); //todo: fetch only my tales
      if (query.isNotEmpty) {
        response = response.ilike('default_locale_title', '%$query%');
      }
      return Result.ok(
        (await response.order(
          'created_at',
        )).map((e) => TaleModel.fromJson(e)).toList(),
      );
    } catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<TaleModel>> getTale(String id) async {
    try {
      final response =
          await _client
              .from("tales")
              .select("*, localization:localizations(*), pages(*, texts(*))")
              .eq("id", id)
              .single();
      final tale = TaleModel.fromJson(response);
      return Result.ok(tale);
    } catch (e) {
      return Result.error(e);
    }
  }
}
