import 'package:fairy_tale_builder_platform/manager/redux/action.dart';
import 'package:fairy_tale_builder_platform/manager/redux/state.dart';
import 'package:fairy_tale_builder_platform/utils/uuid.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared/shared.dart';

class SelectInteractionAction extends DefaultAction {
  final TaleInteraction? interaction;

  SelectInteractionAction({
    this.interaction,
  });

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

class AddInteractionAction extends DefaultAction {
  @override
  AppState? reduce() {
    final page = editorState.selectedPage;

    final newInteraction =
        TaleInteraction.newInteraction(id: UUID.v4(), talePageId: page.id);

    final newPage = page.copyWith(
      interactions: [...page.interactions, newInteraction],
    );

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          editorState: editorState.copyWith(
            selectedPage: newPage,
            selectedInteraction: newInteraction, //once created select it
            isInteractionEdited: false, //todo:
          ),
        ),
      ),
    );
  }
}

class UpdateInteractionAction extends DefaultAction {
  final bool reRender;

  final String? hintKey;
  final num? width;
  final num? height;
  final num? initialdx;
  final num? initialdy;
  final num? finaldx;
  final num? finaldy;
  final String? eventType;
  final String? eventSubType;
  final String? action;
  final int? animationDuration;
  final PlatformFile? imageFile;
  final String? imageUrl;

  UpdateInteractionAction({
    /// when passed as true, re renders all StoreConnectors using selectedTale
    this.reRender = false,
    this.hintKey,
    this.width,
    this.height,
    this.initialdx,
    this.initialdy,
    this.eventType,
    this.eventSubType,
    this.action,
    this.finaldx,
    this.finaldy,
    this.animationDuration, //todo:
    this.imageFile,
    this.imageUrl,
  });

  @override
  AppState? reduce() {
    final page = editorState.selectedPage;
    final tale = taleState.selectedTale;
    final interaction = editorState.selectedInteraction;
    if (interaction.id.isEmpty || page.id.isEmpty || tale.id.isEmpty) {
      return null;
    }

    if (imageFile != null) {
      dispatch(_UpdateInteractionImageAction(imageFile!));
      return null;
    }

    //steps:
    //1. update selected interaction
    final newInteraction = interaction.copyWith(
      toReRender:
          reRender ? interaction.toReRender + 1 : interaction.toReRender,
      hintKey: hintKey ?? interaction.hintKey,
      eventType: eventType ?? interaction.eventType,
      eventSubtype: eventSubType ?? interaction.eventSubtype,
      animationDuration: animationDuration ?? interaction.animationDuration,
      action: action ?? interaction.action,
      metadata: interaction.metadata.copyWith(
        imageUrl: imageUrl ?? interaction.metadata.imageUrl,
        size: interaction.metadata.size.copyWith(
          w: width ?? interaction.metadata.size.width,
          h: height ?? interaction.metadata.size.height,
        ),
        initialPosition: interaction.metadata.initialPosition.copyWith(
          x: initialdx ?? interaction.metadata.initialPosition.dx,
          y: initialdy ?? interaction.metadata.initialPosition.dy,
        ),
        currentPosition: initialdx != null || initialdy != null
            ? interaction.metadata.initialPosition.copyWith(
                x: initialdx ?? interaction.metadata.initialPosition.dx,
                y: initialdy ?? interaction.metadata.initialPosition.dy,
              )
            : interaction.metadata.currentPosition,
        finalPosition: finaldx == null && finaldy == null
            ? null
            : interaction.metadata.finalPosition?.copyWith(
                x: finaldx ?? interaction.metadata.finalPosition?.dx ?? 0,
                y: finaldy ?? interaction.metadata.finalPosition?.dy ?? 0,
              ),
      ),
    );

    //2. update selected page interactions with new selected interaction
    final newInteractions = page.interactions.map((e) {
      if (e.id == interaction.id) {
        return newInteraction;
      }
      return e;
    });
    final newPage = page.copyWith(interactions: newInteractions.toList());

    //3. update tale pages with new selected page
    final newTalePages = tale.pages.map((e) {
      if (e.id == page.id) {
        return newPage;
      }
      return e;
    });
    final newTale = tale.copyWith(pages: newTalePages.toList());

    return state.copyWith(
      taleListState: taleListState.copyWith(
        taleState: taleState.copyWith(
          selectedTale: newTale.copyWith(
            toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
          ),
          editorState: editorState.copyWith(
            selectedInteraction: newInteraction.copyWith(
              toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
            ),
            selectedPage: newPage.copyWith(
              toReRender: reRender ? tale.toReRender + 1 : tale.toReRender,
            ),
            isInteractionEdited: false, //todo:
          ),
        ),
      ),
    );
  }
}

class _UpdateInteractionImageAction extends DefaultAction {
  final PlatformFile file;

  _UpdateInteractionImageAction(this.file);

  @override
  Future<AppState?> reduce() async {
    if (file.bytes == null && file.extension == null) {
      return null;
    }

    final ineraction = taleState.editorState.selectedInteraction;

    final uploadedResult = await taleRepository.uploadFile(
      bytes: await file.xFile.readAsBytes(),
      path:
          'interaction/images/${ineraction.id}.${file.extension!.toLowerCase()}',
    );

    uploadedResult.when(
      ok: (url) {
        dispatch(UpdateInteractionAction(imageUrl: url, reRender: true));
      },
      error: (error) {
        // dispatch(TaleAction(selectedTaleResult: StateResult.error(error)));
        //todo:
      },
    );
    return null;
  }
}
