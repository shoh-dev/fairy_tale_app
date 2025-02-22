import 'package:myspace_data/src/models.dart';
import 'package:myspace_data/src/redux/action.dart';
import 'package:myspace_data/src/redux/state.dart';

class SelectTaleEditorTalePageAction extends DefaultAction {
  final TalePage? page;

  /// if [page] is null, it will unselect the page
  SelectTaleEditorTalePageAction(this.page);

  @override
  AppState reduce() {
    return state.copyWith(
      taleEditorState: state.taleEditorState.copyWith(
        selectedPage: page ?? TalePage.empty,
      ),
    );
  }
}

class UpdateSelectedTalePageAction extends DefaultAction {
  final TalePage page;

  UpdateSelectedTalePageAction(this.page);

  @override
  AppState? reduce() {
    if (page == taleEditorState.selectedPage) {
      return null;
    }
    return state.copyWith(taleEditorState: taleEditorState.copyWith(selectedPage: page));
  }
}

class SelectTaleEditorTalePageInteractionAction extends DefaultAction {
  final List<TaleInteraction> interaction;

  /// if [interaction] is null, it will unselect the page
  SelectTaleEditorTalePageInteractionAction(this.interaction);

  @override
  AppState reduce() {
    return state.copyWith(
      taleEditorState: state.taleEditorState.copyWith(
        selectedInteractions: List.of(interaction),
      ),
    );
  }
}
