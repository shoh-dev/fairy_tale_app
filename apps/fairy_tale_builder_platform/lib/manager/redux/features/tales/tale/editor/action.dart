import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:shared/shared.dart';

class _SelectPageAction extends DefaultAction {
  final TalePage? page;

  _SelectPageAction(this.page);

  @override
  AppState? reduce() {
    if (page == editorState.selectedTalePage) {
      return null;
    }
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedTalePage: page ?? TalePage.empty,
            isTalePageEdited: page != null,
          ),
        ),
      ),
    );
  }
}

class SelectEditorTalePageAction extends DefaultAction {
  final TalePage? page;

  SelectEditorTalePageAction(this.page);

  @override
  AppState? reduce() {
    if (editorState.selectedTalePage != page) {
      dispatch(_SelectPageAction(null));
      Future.delayed(const Duration(milliseconds: 100), () {
        dispatch(_SelectPageAction(page));
      });
    } else {
      dispatch(_SelectPageAction(page));
    }
    return null;
  }
}

class AddNewTalePageAction extends DefaultAction {
  @override
  AppState reduce() {
    final newPage = TalePage.newPage.copyWith(
      id: UUID.v4(),
      text: (taleState.selectedTale.pages.length + 1).toString(),
    );
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: taleState.selectedTale.copyWith(
            pages: [...taleState.selectedTale.pages, newPage],
          ),
          editorState: editorState.copyWith(
            selectedTalePage: newPage,
          ),
        ),
      ),
    );
  }
}

class SetIsTalePageEditedAction extends DefaultAction {
  final TalePage? newPage;

  SetIsTalePageEditedAction({
    required this.newPage,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            isTalePageEdited: newPage != editorState.selectedTalePage,
          ),
        ),
      ),
    );
  }
}

class SaveTalePageAction extends DefaultAction {
  final TalePage page;

  SaveTalePageAction(this.page);
  //todo: save on db

  @override
  AppState reduce() {
    final newTalePages = taleState.selectedTale.pages.map((e) {
      if (e.id == page.id) {
        return page;
      }
      return e;
    }).toList();
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: taleState.selectedTale.copyWith(
            pages: newTalePages,
          ),
          editorState: editorState.copyWith(
            selectedTalePage: page,
            isTalePageEdited: false,
          ),
        ),
      ),
    );
  }
}
