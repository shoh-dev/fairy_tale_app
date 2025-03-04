import 'package:fairy_tale_app/manager/services/environment_key_service.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final EnvironmentKeyService _envKeysService;

  const SupabaseService(this._envKeysService);

  ResultFuture<SupabaseClient> initialize() async {
    try {
      final supabase = await Supabase.initialize(
        url: _envKeysService.supabaseUrl(),
        anonKey: _envKeysService.supabaseKey(),
      );

      return Result.ok(supabase.client);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }
}
