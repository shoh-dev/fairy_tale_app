import 'package:fairy_tale_builder_platform/manager/redux/di/di.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/app/state.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/features.dart';
import 'package:fairy_tale_builder_platform/manager/redux/features/tales/tale/editor/state.dart';
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
  // LocalizationState get localizationState => applicationState.localizationState;
  // LocalizationState2 get localizationState2 =>
  // applicationState.localizationState2;

  //Repositories
  // LocaleRepository get applicationRepository => env.applicationrepository;
  TaleRepository get taleRepository => env.taleRepository;
  AudioPlayerService get mainAudioPlayerService => env.mainAudioPlayerService;
  AudioPlayerService get interactionAudioPlayerService =>
      env.interactionAudioPlayerService;
}
