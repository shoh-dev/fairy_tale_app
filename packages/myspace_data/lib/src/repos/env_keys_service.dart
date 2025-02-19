// this is used to get keys from dart environment using --dart-define-from-file=spec.json
// get value using const String.fromEnvironment("C_H_R");

abstract final class EnvKeysService {
  String get supabaseUrl;
  String get supabaseKey;
}

final class EnvKeysServiceImpl implements EnvKeysService {
  @override
  String get supabaseUrl => const String.fromEnvironment("SUPABASE_URL");

  @override
  String get supabaseKey => const String.fromEnvironment("SUPABASE_KEY");
}
