import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_data_mobile/myspace_data_mobile.dart';

import 'di/di.dart';

abstract class DefaultAction extends ReduxAction<AppState> {
  @override
  DependencyInjection get env => super.env as DependencyInjection;

  TalesState get talesState => state.talesState;
  TaleState get taleState => state.taleState;
  ApplicationState get applicationState => state.applicationState;
  AppLocalizationState get localizationState => applicationState.localizationState;

  // MainAudioPlayerServiceImpl get mainAudioPlayerService => getDependency<MainAudioPlayerServiceImpl>();
  // InteractionAudioPlayerServiceImpl get interactionAudioPlayerService => getDependency<InteractionAudioPlayerServiceImpl>();
  // PathProviderService get pathService => env.pathService;
  ApplicationRepository get applicationRepository => env.applicationService;
  TaleRepository get taleRepository => env.taleRepository;
}
