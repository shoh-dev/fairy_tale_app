import 'package:core_audio/core_audio.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';

abstract class DefaultAction<T> extends ReduxAction<AppState> {
  @override
  DependencyInjection get env => super.env as DependencyInjection;

  //States
  TalesState get talesState => state.talesState;
  TaleState get taleState => state.taleState;
  ApplicationState get applicationState => state.applicationState;
  AppLocalizationState get localizationState => applicationState.localizationState;

  //Repositories
  ApplicationRepository get applicationRepository => env.applicationService;
  TaleRepository get taleRepository => env.taleRepository;
  AudioPlayerRepository get mainAudioPlayerRepository => env.mainAudioPlayerRepository;
  AudioPlayerRepository get interactionAudioPlayerRepository => env.interactionAudioPlayerRepository;

  //Services
  PathProviderService get pathService => env.pathProviderService;
}
