import 'package:async_redux/async_redux.dart';
import 'package:core_audio/core_audio.dart';
import 'package:myspace_data/src/redux.dart';
import 'package:myspace_data/src/redux/di/di.dart';
import 'package:myspace_data/src/repos.dart';
import 'package:myspace_data/src/repos/application_service.dart';
import 'package:myspace_data/src/repos/path_service.dart';

abstract class DefaultAction extends ReduxAction<AppState> {
  T getDependency<T extends Object>() {
    return DependencyInjection.get<T>();
  }

  TalesState get talesState => state.talesState;
  TaleState get taleState => state.taleState;
  ApplicationState get applicationState => state.applicationState;
  AppLocalizationState get localizationState => applicationState.localizationState;

  TaleServiceImpl get taleService => getDependency<TaleServiceImpl>();
  MainAudioPlayerServiceImpl get mainAudioPlayerService => getDependency<MainAudioPlayerServiceImpl>();
  ApplicationServiceImpl get applicationService => getDependency<ApplicationServiceImpl>();
  PathServiceImpl get pathService => getDependency<PathServiceImpl>();
}
