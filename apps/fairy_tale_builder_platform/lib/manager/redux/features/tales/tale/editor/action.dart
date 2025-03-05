import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:shared/shared.dart';

class SelectEditorTalePageAction extends DefaultAction {
  final TalePage? page;

  SelectEditorTalePageAction(this.page);

  @override
  AppState reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedTalePage: page ?? TalePage.empty,
          ),
        ),
      ),
    );
  }
}

class AddNewTalePageAction extends DefaultAction {
  @override
  AppState reduce() {
    final newPage = TalePage.newPage.copyWith(
      id: UUID.v4(),
      text: (taleState.selectedTale.talePages.length + 1).toString(),
    );
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: taleState.selectedTale.copyWith(
            talePages: [...taleState.selectedTale.talePages, newPage],
          ),
          editorState: editorState.copyWith(
            selectedTalePage: newPage,
          ),
        ),
      ),
    );
  }
}
