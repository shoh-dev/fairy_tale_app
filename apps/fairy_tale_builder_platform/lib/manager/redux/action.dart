import 'package:fairy_tale_builder_platform/manager/redux/di/di.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/app/app_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/editor_state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:myspace_data/myspace_data.dart';
import 'package:shared/shared.dart';

abstract class DefaultAction extends ReduxAction<AppState> {
  @override
  DependencyInjection get env => super.env! as DependencyInjection;

  //States
  TaleListState get taleListState => state.taleListState;
  TaleState get taleState => taleListState.taleState;
  TaleEditorState get editorState => taleListState.taleState.editorState;
  ApplicationState get applicationState => state.applicationState;

  //Repositories
  TaleRepository get taleRepository => env.taleRepository;
  AudioPlayerService get mainAudioPlayerService => env.mainAudioPlayerService;
  AudioPlayerService get interactionAudioPlayerService =>
      env.interactionAudioPlayerService;
}
