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
