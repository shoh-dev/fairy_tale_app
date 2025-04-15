// import 'dart:developer';

// import 'package:myspace_core/myspace_core.dart';
// import 'package:tale_builder_flutter/features/tale/model/tale.dart';
// import 'package:tale_builder_flutter/features/tale/repository/tale_repository.dart';
// import 'package:uuid/v4.dart';

// class TaleState {
//   final TaleRepository _taleRepository;

//   TaleState(this._taleRepository, {String? id}) {
//     tale = TaleModel.newTale(
//       id ?? UuidV4().generate(),
//     ).copyWith(isNew: id == null);
//     fetchTaleCommand = CommandParam(_fetchTale)..execute(tale);
//   }

//   late final CommandParam<void, TaleModel> fetchTaleCommand;
//   late TaleModel tale;

//   Future<Result<void>> _fetchTale(TaleModel tale) async {
//     if (tale.isNew) return Result.ok(null);
//     final result = await _taleRepository.getTaleFull(tale.id);
//     switch (result) {
//       case ResultOk<FullTaleResponse>(:final value):
//         log("Fetched tale");
//         this.tale = value.;
//         return Result.ok(null);
//       case ResultError<FullTaleResponse>():
//         log.warning('Fetch tale error: ${result.e}');
//         notifyListeners();
//         return Result.error(result.e);
//     }
//   }

//   void onChangeTaleTitle(String title) {
//     tale = tale.copyWith(title: title);
//     notifyListeners();
//   }

//   void onChangeTaleDescription(String description) {
//     tale = tale.copyWith(description: description);
//     notifyListeners();
//   }

//   void onChangeTaleOrientation(String orientation) {
//     if (orientation == tale.orientation) return;
//     if (_texts.isNotEmpty) {
//       //show prompt that all texts will be aligned on top left when changed and cannot be undone
//       PromptDialog.show(
//         "All texts will be aligned on top left when changed and cannot be undone!",
//         isDestructive: true,
//         onLeftClick: (close) {
//           close();
//         },
//         onRightClick: (close) {
//           final texts = UnmodifiableListView(_texts);
//           for (final text in texts) {
//             onSelectText(text.id, false);
//             onChangeTextPosition(0, 0, false);
//           }
//           onDeselectText(false);
//           tale = tale.copyWith(orientation: orientation);
//           close();
//           notifyListeners();
//         },
//       );
//     } else {
//       tale = tale.copyWith(orientation: orientation);
//       notifyListeners();
//     }
//   }

//   void onChangeTaleCoverImage() async {
//     final result = await _filePickerRepository.pickImageFile();
//     switch (result) {
//       case ResultOk<PlatformFile?>():
//         if (result.value != null) {
//           //upload image
//           final uploadResult = await _taleRepository.uploadCoverImage(
//             taleId: tale.id,
//             file: result.value!,
//           );
//           switch (uploadResult) {
//             case ResultOk<String>():
//               tale = tale.copyWith(
//                 coverImageUrl:
//                     "${uploadResult.value}?q=${DateTime.now().millisecondsSinceEpoch}",
//               );
//               notifyListeners();
//               log.info("Tale cover image is set ${tale.id}");
//               break;
//             case ResultError<String>():
//               ErrorDialog.show(uploadResult.toString());
//               log.warning("Tale cover image error ${result.toString()}");
//               break;
//           }
//         }
//         break;
//       case ResultError<PlatformFile?>():
//         ErrorDialog.show(result.toString());
//         break;
//     }
//   }

//   void onDeleteTaleCoverImage() {
//     PromptDialog.show(
//       "This action cannot be undone!",
//       title: "Delete tale cover image?",
//       isDestructive: true,
//       onLeftClick: (close) {
//         close();
//       },
//       onRightClick: (close) async {
//         final result = await _taleRepository.deleteCoverImage(
//           tale.coverImageBucketPath,
//         );
//         switch (result) {
//           case ResultOk<void>():
//             tale = tale.copyWith(coverImageUrl: "");
//             notifyListeners();
//             break;
//           case ResultError<void>():
//             ErrorDialog.show(result.toString());
//             break;
//         }
//         close();
//       },
//     );
//   }
// }
