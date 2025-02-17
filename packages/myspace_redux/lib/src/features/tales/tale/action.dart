import 'package:myspace_data/myspace_data.dart';
import 'package:myspace_redux/myspace_redux.dart';

class _TaleAction extends DefautAction {
  final Tale? tale;
  final Result<void> taleStatus;

  _TaleAction({
    this.tale,
    required this.taleStatus,
  });

  @override
  AppState reduce() {
    return state.copyWith(
      taleState: taleState.copyWith(
        selectedTale: tale,
        status: taleStatus,
      ),
    );
  }
}

class LoadTaleAction extends DefautAction {
  final String taleId;
  final bool reset;

  LoadTaleAction(this.taleId, {this.reset = false});

  @override
  Future<AppState?> reduce() async {
    if (reset) {
      dispatch(_TaleAction(taleStatus: Result.loading()));
      return null;
    }

    final tale = await taleService.getTaleById(taleId);

    tale.fold(
      (tale) {
        dispatch(_TaleAction(tale: tale, taleStatus: Result.ok(null)));
      },
      (error) {
        dispatch(_TaleAction(taleStatus: Result.error(error)));
      },
      () => dispatch(_TaleAction(taleStatus: Result.loading())),
    );
    return null;
  }
}

// class UpdateSelectedTaleInteractionAction extends DefautAction {
//   final TaleInteraction interaction;

//   UpdateSelectedTaleInteractionAction(this.interaction);

//   @override
//   AppState? reduce() {
//     final taleResult = state.talesState.selectedTale;
//     if (!taleResult.isOk) return null;
//     final tale = taleResult.asOk.value;

//     switch (interaction.eventTypeEnum) {
//       case TaleInteractionEventType.swipe:
//         // TODO: Handle this case.
//         throw UnimplementedError();
//       case TaleInteractionEventType.tap:
//         // TODO: Handle this case.
//         throw UnimplementedError();
//     }
//   }
// }
