import 'package:fairy_tale_mobile/manager/redux.dart';
import 'package:fairy_tale_mobile/manager/redux/features/app/state.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

abstract class DefaultAction extends ReduxAction<AppState> {
  @override
  DependencyInjection get env => super.env! as DependencyInjection;

  //States
  TaleListState get taleListState => state.taleListState;
  TaleState get taleState => taleListState.taleState;
  ApplicationState get applicationState => state.applicationState;
  LocalizationState get localizationState => applicationState.localizationState;

  //Repositories
  TaleRepository get taleRepository => env.taleRepository;
  AudioPlayerService get mainAudioPlayerService => env.mainAudioPlayerService;
  AudioPlayerService get interactionAudioPlayerService =>
      env.interactionAudioPlayerService;

  //Services
  PathProviderService get pathService => env.pathProviderService;
}
