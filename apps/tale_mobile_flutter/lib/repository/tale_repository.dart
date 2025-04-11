import 'package:myspace_core/myspace_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_mobile_flutter/features/tale/model/tale.dart';

class TaleRepository extends Dependency {
  final SupabaseClient _client;

  const TaleRepository(SupabaseClient client) : _client = client;

  Future<Result<List<TaleModel>>> getMyTales() async {
    try {
      final response =
          await _client.from("tales").select(); //todo: fetch only my tales
      await Future.delayed(Duration(seconds: 1));
      return Result.ok(response.map((e) => TaleModel.fromJson(e)).toList());
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
      await Future.delayed(Duration(seconds: 1));
      final tale = TaleModel.fromJson(response);
      return Result.ok(tale);
    } catch (e) {
      return Result.error(e);
    }
  }
}
