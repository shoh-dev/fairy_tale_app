import 'package:fairy_tale_app/manager/redux.dart';
import 'package:fairy_tale_app/manager/redux/features/app/state.dart';
import 'package:fairy_tale_app/manager/repositories.dart';
import 'package:fairy_tale_app/manager/services.dart';
import 'package:myspace_data/myspace_data.dart';

abstract class DefaultAction extends ReduxAction<AppState> {
  @override
  DependencyInjection get env => super.env! as DependencyInjection;

  //States
  TaleListState get taleListState => state.taleListState;
  TaleState get taleState => taleListState.taleState;
  ApplicationState get applicationState => state.applicationState;
  LocalizationState get localizationState => applicationState.localizationState;

  //Repositories
  LocaleRepository get applicationRepository => env.applicationrepository;
  TaleRepository get taleRepository => env.taleRepository;
  AudioPlayerService get mainAudioPlayerService => env.mainAudioPlayerService;
  AudioPlayerService get interactionAudioPlayerService =>
      env.interactionAudioPlayerService;

  //Services
  PathProviderService get pathService => env.pathProviderService;
}
