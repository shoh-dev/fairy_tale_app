import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/environment_key_service.dart';

abstract class SupabaseRepository {
  final EnvironmentKeyService _envKeysService;
  const SupabaseRepository(this._envKeysService);

  ResultFuture<SupabaseClient> initialize();
}

class SupabaseRepositoryImpl extends SupabaseRepository {
  const SupabaseRepositoryImpl(super._envKeysService);

  @override
  ResultFuture<SupabaseClient> initialize() async {
    try {
      final supabase = await Supabase.initialize(
        url: _envKeysService.supabaseUrl,
        anonKey: _envKeysService.supabaseKey,
      );

      return Result.ok(supabase.client);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
