import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_builder_flutter/features/tale/model/localization.dart';
import 'package:tale_builder_flutter/features/tale/model/page.dart';
import 'package:tale_builder_flutter/features/tale/model/tale.dart';
import 'package:tale_builder_flutter/features/tale/model/text.dart';
import 'package:tale_builder_flutter/features/tale/repository/localization_repository.dart';
import 'package:tale_builder_flutter/features/tale/repository/pages_repository.dart';
import 'package:tale_builder_flutter/features/tale/repository/tale_repository.dart';
import 'package:tale_builder_flutter/features/tale/repository/texts_repository.dart';
import 'package:uuid/v4.dart';

// FlutterTts flutterTts = FlutterTts();
//   // flutterTts.getLanguages.then(print);
//   flutterTts.getVoices.then(
//     (value) => print(
//       (value as List).where((element) => element['locale'] == 'ru-RU'),
//     ),
//   );
//   // return;

//   flutterTts.setSpeechRate(.5).then((_) {
//     flutterTts.setVoice({"name": "Karen", "locale": "en-AU"}).then((value) {
//       // flutterTts.setVoice({"name": "Milena", "locale": "ru-RU"}).then((value) {
//       // flutterTts.speak("Меня зовут Фарах").then(print);
//       flutterTts.speak('context textTheme titleMedium').then(print);
//     });
//   });

//   return;

class TaleViewModel extends Vm {
  final TaleRepository _taleRepository;

  TaleViewModel({required TaleRepository taleRepository, String? id})
    : _taleRepository = taleRepository {
    tale = TaleModel.newTale(
      id ?? UuidV4().generate(),
    ).copyWith(isNew: id == null || id == 'null' || id == 'new');
    localization = TaleLocalizationModel.empty(tale.id);

    fetchTaleCommand = CommandParam(_fetchTale)..execute(tale);
  }

  //Tale
  late final CommandParam<void, TaleModel> fetchTaleCommand;
  late TaleModel tale;

  Future<Result<void>> _fetchTale(TaleModel tale) async {
    if (tale.isNew) return Result.ok(null);
    final result = await _taleRepository.getTaleFull(tale.id);
    switch (result) {
      case ResultOk<FullTaleResponse>():
        final value = result.value;
        this.tale = value.tale;
        localization = value.localization;
        _pages
          ..clear()
          ..addAll(value.pages);
        _texts
          ..clear()
          ..addAll(value.texts);
        log.info("Fetched tale");
        notifyListeners();
        return Result.ok(null);
      case ResultError<FullTaleResponse>():
        log.warning('Fetch tale error: ${result.e}');
        notifyListeners();
        return Result.error(result.e);
    }
  }

  void onChangeTaleTitle(String title) {
    tale = tale.copyWith(title: title);
    notifyListeners();
  }

  void onChangeTaleDescription(String description) {
    tale = tale.copyWith(description: description);
    notifyListeners();
  }

  void onChangeTaleOrientation(String orientation) {
    tale = tale.copyWith(orientation: orientation);
    notifyListeners();
  }

  //Tale

  //Translations
  late TaleLocalizationModel localization;

  void onChangeLocalizationDefaultLocale(String locale) {
    localization = localization.copyWith(defaultLocale: locale);
    notifyListeners();
  }
  //Translations

  //Pages
  final List<TalePageModel> _pages = List.empty(growable: true);
  UnmodifiableListView<TalePageModel> get pages => UnmodifiableListView(
    _pages..sort((a, b) => a.pageNumber > b.pageNumber ? 1 : 0),
  );
  String selectedPageId = '';
  TalePageModel? get selectedPage =>
      pages.firstWhereOrNull((element) => element.id == selectedPageId);

  void onSelectPage(TalePageModel page) {
    if (page.id != selectedPageId) {
      selectedPageId = page.id;
      selectedTextId = '';
      notifyListeners();
    }
  }

  void onDeselectPage() {
    if (selectedPageId.isNotEmpty) {
      selectedPageId = '';
      selectedTextId = '';
      notifyListeners();
    }
  }

  void onAddPage() {
    final newPage = TalePageModel.newPage(
      id: UuidV4().generate(),
      taleId: tale.id,
      text: "Page ${pages.length + 1}",
      pageNumber: pages.length + 1,
    );
    _pages.add(newPage);
    selectedPageId = newPage.id;
    notifyListeners();
  }

  void onDeletePage(String id) {
    final page = pages.firstWhereOrNull((p) => p.id == id);
    if (page != null) {
      if (page.isNew) {
        _pages.removeWhere((element) => element.id == id);
        selectedPageId = '';
        notifyListeners();
      } else {
        PromptDialog.show(
          "This action cannot be undone!",
          title: "Delete page?",
          isDestructive: true,
          onLeftClick: (close) {
            close();
          },
          onRightClick: (close) {
            //todo: delete from server
            selectedPageId = '';
            close();
          },
        );
      }
    }
  }

  void onChangePageNumber(int pageNumber) {
    final index = _pages.indexWhere((element) => element.id == selectedPageId);
    if (index == -1) return;
    final newPage = _pages[index];
    final nextPageIndex = _pages.indexWhere(
      (element) => element.pageNumber == pageNumber,
    );
    if (nextPageIndex == -1) return;
    final nextPage = _pages[nextPageIndex];
    _pages[nextPageIndex] = nextPage.copyWith(pageNumber: newPage.pageNumber);
    _pages[index] = newPage.copyWith(pageNumber: pageNumber);
    notifyListeners();
  }
  //Pages

  //Texts
  final List<TalePageTextModel> _texts = List.empty(growable: true);
  UnmodifiableListView<TalePageTextModel> get texts =>
      UnmodifiableListView(_texts);
  String selectedTextId = '';
  TalePageTextModel? get selectedText =>
      texts.firstWhereOrNull((element) => element.id == selectedTextId);

  void onSelectText(TalePageTextModel text) {
    if (text.id != selectedTextId) {
      selectedTextId = text.id;
      notifyListeners();
    }
  }

  void onDeselectText() {
    if (selectedTextId.isNotEmpty) {
      selectedTextId = '';
      notifyListeners();
    }
  }

  void _updateText(TalePageTextModel text) {
    final index = _texts.indexWhere((element) => element.id == selectedTextId);
    if (index == -1) return;
    _texts[index] = text;
  }

  void onChangeTextText(String text) {
    if (selectedTextId.isEmpty) return;
    _updateText(selectedText!.copyWith(text: text));
    notifyListeners();
  }

  void onChangeTextSize([double? width, double? height]) {
    if (selectedTextId.isEmpty) return;
    if (width == null && height == null) return;
    _updateText(
      selectedText!.copyWith(
        width: width?.ceil().toDouble() ?? selectedText!.width,
        height: height?.ceil().toDouble() ?? selectedText!.height,
      ),
    );
    notifyListeners();
  }

  void onChangeTextPosition([double? dx, double? dy]) {
    if (selectedTextId.isEmpty) return;
    if (dx == null && dy == null) return;

    _updateText(
      selectedText!.copyWith(
        dx: dx?.ceil().toDouble() ?? selectedText!.dx,
        dy: dy?.ceil().toDouble() ?? selectedText!.dy,
      ),
    );
    notifyListeners();
  }

  void onChangeTextFontSize(double size) {
    if (selectedTextId.isEmpty) return;
    TextStyle style = selectedText?.style ?? TextStyle();
    style = style.copyWith(fontSize: size.ceil().toDouble());

    _updateText(selectedText!.copyWith(style: style));
    notifyListeners();
  }

  void onAddText() {
    if (selectedPageId.isEmpty) return;
    _texts.add(TalePageTextModel.newText(UuidV4().generate(), selectedPageId));
    notifyListeners();
  }

  void onDeleteText(String id) {
    final text = _texts.firstWhereOrNull((p) => p.id == id);
    if (text != null) {
      if (text.isNew) {
        _texts.removeWhere((element) => element.id == id);
        selectedTextId = '';
        notifyListeners();
      } else {
        PromptDialog.show(
          "This action cannot be undone!",
          title: "Delete text?",
          isDestructive: true,
          onLeftClick: (close) {
            close();
          },
          onRightClick: (close) {
            //todo: delete from server
            selectedTextId = '';
            close();
          },
        );
      }
    }
  }

  //Texts
}

// class _TaleState {
//   final TaleModel tale;

//   _TaleState({required this.tale});

//   _TaleState _copy(TaleModel tale) {
//     return _TaleState(tale: tale);
//   }

//   _TaleState onChangeTaleTitle(String title) {
//     return _copy(tale.copyWith(title: title));
//   }

//   _TaleState onChangeTaleDescription(String description) {
//     return _copy(tale.copyWith(description: description));
//   }

//   _TaleState onChangeTaleOrientation(String orientation) {
//     return _copy(tale.copyWith(orientation: orientation));
//   }
// }

// class _PageState {
//   final List<TalePageModel> _pages;
//   final String _selectedPageId ;

//   _PageState({
//        required List<TalePageModel> _pages,
//    required String _selectedPageId ,
//   }) : _pages =;

//   _PageState onChangeTaleTitle(String title) {
//     return _copy(tale.copyWith(title: title));
//   }

//   _PageState onChangeTaleDescription(String description) {
//     return _copy(tale.copyWith(description: description));
//   }

//   _PageState onChangeTaleOrientation(String orientation) {
//     return _copy(tale.copyWith(orientation: orientation));
//   }
// }
