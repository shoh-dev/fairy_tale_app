import 'package:myspace_core/myspace_core.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_builder_flutter/features/tale/model/object.dart';

final _objects = <TaleObjectModel>[
  // TaleObjectModel(
  // imageUrl:
  // 'http://127.0.0.1:54321/storage/v1/object/public/default/object/ChatGPT%20Image%20Apr%2012,%202025,%2004_08_23%20PM.png',
  // ),
];

class TaleObjectsRepository extends Dependency {
  final SupabaseClient _client;

  const TaleObjectsRepository(SupabaseClient client) : _client = client;

  Future<Result<List<TaleObjectModel>>> getLocalization(String taleId) async {
    try {
      // final response =
      // await _client
      // .from("objects")
      // .select()
      // .eq("tale_id", taleId);
      return Result.ok(List.of(_objects));
    } catch (e) {
      return Result.error(e);
    }
  }
}
