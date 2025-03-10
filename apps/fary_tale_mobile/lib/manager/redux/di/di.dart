import 'dart:async';

import 'package:fairy_tale_mobile/manager/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class DependencyInjection extends ReduxDependencyInjection {
  late final SupabaseService supabaseRepository;
  late final TaleRepository taleRepository;
  late final PathProviderService pathProviderService;
  late final DeviceService deviceService;

  @override
  Future<Result<void>> init() async {
    try {
      deviceService = const DeviceService();
      pathProviderService = PathProviderService();
      InteractionAudioPlayerService() as AudioPlayerService;
      supabaseRepository = SupabaseService(EnvironmentKeyService());
      final supabaseClient = await supabaseRepository.initialize();
      return supabaseClient.when(
        ok: (client) {
          taleRepository = TaleRepositoryImpl(client) as TaleRepository;
          return const Result.ok(null);
        },
        error: Result.error,
      );
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }
}
