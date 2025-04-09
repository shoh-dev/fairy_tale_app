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
  final TaleLocalizationRepository _localizationRepository;
  final TalePagesRepository _pagesRepository;
  final TalePageTextsRepository _textsRepository;

  TaleViewModel({
    required TaleRepository taleRepository,
    required TaleLocalizationRepository localizationRepository,
    required TalePagesRepository pagesRepository,
    required TalePageTextsRepository textsRepository,
    String? id,
  }) : _taleRepository = taleRepository,
       _localizationRepository = localizationRepository,
       _pagesRepository = pagesRepository,
       _textsRepository = textsRepository {
    tale = TaleModel.newTale(
      id ?? UuidV4().generate(),
    ).copyWith(isNew: id == null || id == 'null' || id == 'new');
    localization = TaleLocalizationModel.empty(tale.id);

    fetchTaleCommand = CommandParam(_fetchTale)..execute(tale);
    fetchLocalizationCommand = CommandParam(_fetchLocalization)..execute(tale);
    fetchPagesCommand = CommandParam(_fetchPages)..execute(tale);
    fetchTextsCommand = CommandParam(_fetchTexts)..execute(tale);
  }

  //Tale
  late final CommandParam<void, TaleModel> fetchTaleCommand;
  late TaleModel tale;

  Future<Result<void>> _fetchTale(TaleModel tale) async {
    if (tale.isNew) return Result.ok(null);

    final result = await _taleRepository.getTale(tale.id);
    switch (result) {
      case ResultOk<TaleModel>():
        this.tale = result.value;
        log.info("Fetched tale");
        notifyListeners();
        return Result.ok(null);
      case ResultError<TaleModel>():
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
  late final CommandParam<void, TaleModel> fetchLocalizationCommand;
  late TaleLocalizationModel localization;

  Future<Result<void>> _fetchLocalization(TaleModel tale) async {
    if (tale.isNew) return Result.ok(null);

    final result = await _localizationRepository.getLocalization(tale.id);
    switch (result) {
      case ResultOk<TaleLocalizationModel>():
        localization = result.value;
        log.info("Fetched localization");
        notifyListeners();
        return Result.ok(null);
      case ResultError<TaleLocalizationModel>():
        log.warning('Fetch localization error: ${result.e}');
        notifyListeners();
        return Result.error(result.e);
    }
  }

  void onChangeLocalizationDefaultLocale(String locale) {
    localization = localization.copyWith(defaultLocale: locale);
    notifyListeners();
  }
  //Translations

  //Pages
  late final CommandParam<void, TaleModel> fetchPagesCommand;
  final List<TalePageModel> _pages = List.empty(growable: true);
  UnmodifiableListView<TalePageModel> get pages => UnmodifiableListView(
    _pages..sort((a, b) => a.pageNumber > b.pageNumber ? 1 : 0),
  );
  String selectedPageId = '';
  TalePageModel? get selectedPage =>
      pages.firstWhereOrNull((element) => element.id == selectedPageId);

  Future<Result<void>> _fetchPages(TaleModel tale) async {
    if (tale.isNew) return Result.ok(null);

    final result = await _pagesRepository.getPages(tale.id);
    switch (result) {
      case ResultOk<List<TalePageModel>>():
        _pages.clear();
        _pages.addAll(result.value);
        log.info("Fetched pages");
        notifyListeners();
        return Result.ok(null);
      case ResultError<List<TalePageModel>>():
        log.warning('Fetch pages error: ${result.e}');
        notifyListeners();
        return Result.error(result.e);
    }
  }

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
    _pages.add(
      TalePageModel.newPage(
        id: UuidV4().generate(),
        taleId: tale.id,
        text: "Page ${pages.length + 1}",
        pageNumber: pages.length + 1,
      ),
    );
    notifyListeners();
  }

  void onDeletePage(String id) {
    final page = pages.firstWhereOrNull((p) => p.id == id);
    if (page != null) {
      if (page.isNew) {
        _pages.removeWhere((element) => element.id == id);
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
  late final CommandParam<void, TaleModel> fetchTextsCommand;
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

  Future<Result<void>> _fetchTexts(TaleModel tale) async {
    if (tale.isNew) return Result.ok(null);

    final result = await _textsRepository.getTexts(tale.id);
    switch (result) {
      case ResultOk<List<TalePageTextModel>>():
        _texts.clear();
        _texts.addAll(result.value);
        log.info("Fetched texts");
        notifyListeners();
        return Result.ok(null);
      case ResultError<List<TalePageTextModel>>():
        log.warning('Fetch texts error: ${result.e}');
        notifyListeners();
        return Result.error(result.e);
    }
  }

  void _updateText(TalePageTextModel text) {
    final index = _texts.indexWhere((element) => element.id == selectedTextId);
    if (index == -1) return;
    _texts[index] = text;
  }

  void onChangeTextText(String text) {
    if (selectedText == null) return;
    _updateText(selectedText!.copyWith(text: text));
    notifyListeners();
  }

  void onChangeTextSize([double? width, double? height]) {
    if (selectedText == null) return;
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
    if (selectedText == null) return;
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
    if (selectedText == null) return;
    TextStyle style = selectedText?.style ?? TextStyle();
    style = style.copyWith(fontSize: size.ceil().toDouble());

    _updateText(selectedText!.copyWith(style: style));
    notifyListeners();
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
