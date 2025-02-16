import 'package:myspace_data/myspace_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseService {
  ResultFuture<SupabaseClient> initialize({required String url, required String key});
}

class SupabaseServiceImpl implements SupabaseService {
  @override
  ResultFuture<SupabaseClient> initialize({required String url, required String key}) async {
    try {
      final supabase = await Supabase.initialize(
        url: url,
        anonKey: key,
      );

      return Result.ok(supabase.client);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
