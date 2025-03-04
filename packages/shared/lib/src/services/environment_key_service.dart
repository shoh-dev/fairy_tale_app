// this is used to get keys from dart environment using
// --dart-define-from-file=spec.json

// get value using const String.fromEnvironment("C_H_R");

import 'package:myspace_data/myspace_data.dart';

final class EnvironmentKeyService {
  String supabaseUrl() {
    try {
      const key = String.fromEnvironment('SUPABASE_URL');
      if (key.isEmpty) {
        throw const ErrorX('SUPABASE_URL not found in environment');
      }
      return key;
    } catch (e) {
      throw ErrorX(e);
    }
  }

  String supabaseKey() {
    try {
      const key = String.fromEnvironment('SUPABASE_KEY');
      if (key.isEmpty) {
        throw const ErrorX('SUPABASE_KEY not found in environment');
      }
      return key;
    } catch (e) {
      throw ErrorX(e);
    }
  }
}
