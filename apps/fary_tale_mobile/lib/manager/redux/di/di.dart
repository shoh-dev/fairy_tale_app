import 'dart:async';

import 'package:fairy_tale_mobile/manager/services.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class DependencyInjection extends ReduxDependencyInjection {
  late final LocaleRepository applicationrepository;
  late final SupabaseService supabaseRepository;
  late final TaleRepository taleRepository;
  late final PathProviderService pathProviderService;
  late final AudioPlayerService interactionAudioPlayerService;
  late final AudioPlayerService mainAudioPlayerService;
  late final DeviceService deviceService;

  @override
  Future<Result<void>> init() async {
    try {
      deviceService = const DeviceService();
      pathProviderService = PathProviderService();
      interactionAudioPlayerService =
          InteractionAudioPlayerService() as AudioPlayerService;
      mainAudioPlayerService = MainAudioPlayerService() as AudioPlayerService;
      supabaseRepository = SupabaseService(EnvironmentKeyService());
      final supabaseClient = await supabaseRepository.initialize();
      return supabaseClient.when(
        ok: (client) {
          applicationrepository =
              LocaleRepositoryImpl(client) as LocaleRepository;
          taleRepository = TaleRepositoryImpl(client) as TaleRepository;
          return const Result.ok(null);
        },
        error: Result.error,
      );
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  void dispose() {
    interactionAudioPlayerService.dispose();
    mainAudioPlayerService.dispose();
    super.dispose();
  }
}
