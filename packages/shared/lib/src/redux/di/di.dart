import 'dart:async';

import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

class DependencyInjection extends ReduxDependencyInjection {
  late final SupabaseService supabaseRepository;
  late final TaleRepository taleRepository;
  late final AudioPlayerService interactionAudioPlayerService;
  late final AudioPlayerService mainAudioPlayerService;

  @override
  Future<Result<void>> init() async {
    try {
      interactionAudioPlayerService =
          InteractionAudioPlayerService() as AudioPlayerService;
      mainAudioPlayerService = MainAudioPlayerService() as AudioPlayerService;
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

  @override
  void dispose() {
    interactionAudioPlayerService.dispose();
    mainAudioPlayerService.dispose();
    super.dispose();
  }
}
