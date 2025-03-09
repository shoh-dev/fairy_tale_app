import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:shared/shared.dart';

class SelectInteractionAction extends DefaultAction {
  final TaleInteraction? interaction;

  SelectInteractionAction(this.interaction);

  @override
  AppState? reduce() {
    if (editorState.selectedInteraction == interaction) {
      return null;
    }

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedInteraction:
                interaction ?? TaleInteraction.empty(id: '', talePageId: ''),
          ),
        ),
      ),
    );
  }
}

class UpdateSelectedInteractionAction extends DefaultAction {
  final TaleInteraction interaction;

  UpdateSelectedInteractionAction(this.interaction);

  @override
  AppState? reduce() {
    if (editorState.selectedInteraction == interaction) {
      return null;
    }

    final selectedPage = editorState.selectedPage;
    final interactions = selectedPage.interactions.map((e) {
      if (e.id == interaction.id) {
        return interaction;
      }
      return e;
    });

    final newPage = selectedPage.copyWith(interactions: interactions.toList());

    final oldPages = taleListState.taleState.selectedTale.pages;
    final oldPage = oldPages.firstWhere((element) => element.id == newPage.id);

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            isInteractionEdited:
                !listEquals(oldPage.interactions, newPage.interactions),
            selectedInteraction: interaction,
            selectedPage: newPage,
          ),
        ),
      ),
    );
  }
}

class SaveInteractionsAction extends DefaultAction {
  @override
  AppState? reduce() {
    final selectedPage = editorState.selectedPage;
    //replace page with selectedPage from list of selectedTale pages
    final newPages = taleListState.taleState.selectedTale.pages.map((e) {
      if (e.id == selectedPage.id) {
        return selectedPage;
      }
      return e;
    });

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            isInteractionEdited: false,
          ),
          selectedTale: taleState.selectedTale.copyWith(
            pages: newPages.toList(),
          ),
        ),
      ),
    );
  }
}

class AddEmptyInteractionAction extends DefaultAction {
  @override
  AppState? reduce() {
    final selectedPage = editorState.selectedPage;
    final newPage = selectedPage.copyWith(
      interactions: [
        ...selectedPage.interactions,
        TaleInteraction.newInteraction(
          id: UUID.v4(),
          talePageId: selectedPage.id,
        ),
      ],
    );
    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedPage: newPage,
            isInteractionEdited: true,
          ),
        ),
      ),
    );
  }
}

class AddSelectedInteractionImageAction extends DefaultAction {
  final PlatformFile file;

  AddSelectedInteractionImageAction(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final ineraction = taleState.editorState.selectedInteraction;

    final uploadedResult = await taleRepository.uploadImage(
      bytes: await file.xFile.readAsBytes(),
      path:
          'interaction_objects/${ineraction.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(
          UpdateSelectedInteractionAction(
            ineraction.copyWith(
              metadata: ineraction.metadata.copyWith(imageUrl: url),
              toReRender: ineraction.toReRender + 1,
            ),
          ),
        );

        dispatch(SaveInteractionsAction());
      },
      error: (error) {
        // dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
        //todo:
      },
    );
    return null;
  }
}
