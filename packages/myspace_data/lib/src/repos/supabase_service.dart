import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseService {
  final EnvKeysServiceImpl _envKeysService;
  const SupabaseService(this._envKeysService);

  ResultFuture<SupabaseClient> initialize();
}

class SupabaseServiceImpl extends SupabaseService {
  const SupabaseServiceImpl(super._envKeysService);

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
