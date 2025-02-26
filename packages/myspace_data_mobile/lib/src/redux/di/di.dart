import 'dart:async';

import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/src/repositories.dart';
import 'package:myspace_data_mobile/src/services.dart';

import 'package:core_audio/core_audio.dart';

class DependencyInjection extends ReduxDependencyInjection {
  late final LocaleRepository applicationrepository;
  late final SupabaseService supabaseRepository;
  late final TaleRepository taleRepository;
  late final PathProviderService pathProviderService;
  late final AudioPlayerRepository interactionAudioPlayerRepository;
  late final AudioPlayerRepository mainAudioPlayerRepository;

  @override
  Future<Result> init() async {
    try {
      pathProviderService = PathProviderServiceImpl() as PathProviderService;
      interactionAudioPlayerRepository = InteractionAudioPlayerRepositoryImpl() as AudioPlayerRepository;
      mainAudioPlayerRepository = MainAudioPlayerRepositoryImpl() as AudioPlayerRepository;
      supabaseRepository = SupabaseServiceImpl(EnvironmentKeyServiceImpl() as EnvironmentKeyService);
      final supabaseClient = await supabaseRepository.initialize();
      return supabaseClient.fold(
        (client) {
          applicationrepository = LocaleRepositoryImpl(client) as LocaleRepository;
          taleRepository = TaleRepositoryImpl(client) as TaleRepository;
          return Result.ok(null);
        },
        (error) => Result.error(error),
      );
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }
}
