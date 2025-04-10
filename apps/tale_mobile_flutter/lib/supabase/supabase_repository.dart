import 'package:myspace_core/myspace_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRepository extends Dependency {
  final SupabaseClient client;

  SupabaseRepository(this.client);

  static Future<SupabaseRepository> initialize(
    String url,
    String anonKey,
  ) async {
    final supabase = await Supabase.initialize(url: url, anonKey: anonKey);
    return SupabaseRepository(supabase.client);
  }
}
