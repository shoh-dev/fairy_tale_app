import 'package:async_redux/async_redux.dart';
import 'package:core_audio/core_audio.dart';
import 'package:myspace_data/src/redux.dart';
import 'package:myspace_data/src/redux/di/di.dart';
import 'package:myspace_data/src/repos.dart';

abstract class DefautAction extends ReduxAction<AppState> {
  T getDependency<T extends Object>() {
    return DependencyInjection.get<T>();
  }

  TalesState get talesState => state.talesState;
  TaleState get taleState => state.taleState;

  TaleServiceImpl get taleService => getDependency<TaleServiceImpl>();
  AudioPlayerServiceImpl get audioPlayerService => getDependency<AudioPlayerServiceImpl>();
}
