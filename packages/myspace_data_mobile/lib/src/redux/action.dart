import 'package:core_audio/core_audio.dart';
import 'package:myspace_data/myspace_data.dart' as data;

abstract class DefaultAction extends data.DefaultAction<AppState> {
  TalesState get talesState => state.talesState;
  TaleState get taleState => state.taleState;
  ApplicationState get applicationState => state.applicationState;
  AppLocalizationState get localizationState => applicationState.localizationState;
  TaleEditorState get taleEditorState => state.taleEditorState;

  TaleServiceImpl get taleService => getDependency<TaleServiceImpl>();
  MainAudioPlayerServiceImpl get mainAudioPlayerService => getDependency<MainAudioPlayerServiceImpl>();
  InteractionAudioPlayerServiceImpl get interactionAudioPlayerService => getDependency<InteractionAudioPlayerServiceImpl>();
  ApplicationServiceImpl get applicationService => getDependency<ApplicationServiceImpl>();
  PathServiceImpl get pathService => getDependency<PathServiceImpl>();
}
