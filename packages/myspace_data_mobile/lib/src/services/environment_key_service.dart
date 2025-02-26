// this is used to get keys from dart environment using --dart-define-from-file=spec.json
// get value using const String.fromEnvironment("C_H_R");

import 'package:myspace_data/myspace_data.dart';

abstract final class EnvironmentKeyService {
  String supabaseUrl();
  String supabaseKey();
}

final class EnvironmentKeyServiceImpl implements EnvironmentKeyService {
  @override
  String supabaseUrl() {
    try {
      final key = const String.fromEnvironment("SUPABASE_URL");
      if (key.isEmpty) {
        throw ErrorX("SUPABASE_URL not found in environment");
      }
      return key;
    } catch (e, st) {
      throw ErrorX(e, st);
    }
  }

  @override
  String supabaseKey() {
    try {
      final key = const String.fromEnvironment("SUPABASE_KEY");
      if (key.isEmpty) {
        throw ErrorX("SUPABASE_KEY not found in environment");
      }
      return key;
    } catch (e, st) {
      throw ErrorX(e, st);
    }
  }
}
