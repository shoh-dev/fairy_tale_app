import 'package:core_audio/core_audio.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';

abstract class DefaultAction<T> extends ReduxAction<AppState> {
  @override
  DependencyInjection get env => super.env as DependencyInjection;

  //States
  TaleListState get taleListState => state.taleListState;
  TaleState get taleState => taleListState.taleState;
  ApplicationState get applicationState => state.applicationState;
  LocalizationState get localizationState => applicationState.localizationState;

  //Repositories
  LocaleRepository get applicationRepository => env.applicationrepository;
  TaleRepository get taleRepository => env.taleRepository;
  AudioPlayerRepository get mainAudioPlayerRepository => env.mainAudioPlayerRepository;
  AudioPlayerRepository get interactionAudioPlayerRepository => env.interactionAudioPlayerRepository;

  //Services
  PathProviderService get pathService => env.pathProviderService;
}
