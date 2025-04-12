import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';
import 'package:tale_builder_flutter/features/tale/model/localization.dart';
import 'package:tale_builder_flutter/features/tale/model/object.dart';
import 'package:tale_builder_flutter/features/tale/model/page.dart';
import 'package:tale_builder_flutter/features/tale/model/tale.dart';
import 'package:tale_builder_flutter/features/tale/model/text.dart';
import 'package:tale_builder_flutter/features/tale/repository/pages_repository.dart';
import 'package:tale_builder_flutter/features/tale/repository/tale_repository.dart';
import 'package:tale_builder_flutter/features/tale/view/translations_view.dart';
import 'package:tale_builder_flutter/repository/file_picker_repository.dart';
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
  final TalePagesRepository _pageRepository;
  final FilePickerRepository _filePickerRepository;

  TaleViewModel({
    required TaleRepository taleRepository,
    required TalePagesRepository pageRepository,
    required FilePickerRepository filePickerRepository,
    String? id,
  }) : _taleRepository = taleRepository,
       _filePickerRepository = filePickerRepository,
       _pageRepository = pageRepository {
    isCreate = id == null || id == 'null' || id == 'new';
    tale = TaleModel.newTale(
      isCreate ? UuidV4().generate() : id!,
    ).copyWith(isNew: isCreate);
    localization = TaleLocalizationModel.empty(tale.id);

    fetchTaleCommand = CommandParam(_fetchTale)..execute(tale);
  }

  // UI
  late bool isCreate;
  bool _isPreviewMode = false;
  bool get isPreviewMode => _isPreviewMode;

  void togglePreviewMode() {
    _isPreviewMode = !_isPreviewMode;
    selectedTextId = '';
    notifyListeners();
  }
  // UI

  // Objects
  final UnmodifiableListView<TaleObjectModel> objects = UnmodifiableListView([
  ]);
  // Objects

  //Tale
  late final CommandParam<void, TaleModel> fetchTaleCommand;
  late TaleModel tale;

  Future<bool> onSave() async {
    final result = await _taleRepository.upsertFullTale(
      tale: tale,
      localization: localization,
      pages: _pages,
      texts: _texts,
    );
    switch (result) {
      case ResultOk<FullTaleResponse>():
        _reset(result.value);
        SuccessDialog.show("Saved successfully!");
        notifyListeners();
        isCreate = false;
        break;
      case ResultError<FullTaleResponse>():
        ErrorDialog.show(result.toString());
        break;
    }
    return result.isOk;
  }

  void _reset(FullTaleResponse newData) {
    // selectedPageId = '';
    // selectedTextId = '';
    tale = newData.tale;
    localization = newData.localization;
    _pages
      ..clear()
      ..addAll(newData.pages);
    _texts
      ..clear()
      ..addAll(newData.texts);
  }

  Future<Result<void>> _fetchTale(TaleModel tale) async {
    if (tale.isNew) return Result.ok(null);
    final result = await _taleRepository.getTaleFull(tale.id);
    switch (result) {
      case ResultOk<FullTaleResponse>():
        final value = result.value;
        _reset(value);
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
    if (orientation == tale.orientation) return;
    if (_texts.isNotEmpty) {
      //show prompt that all texts will be aligned on top left when changed and cannot be undone
      PromptDialog.show(
        "All texts will be aligned on top left when changed and cannot be undone!",
        isDestructive: true,
        onLeftClick: (close) {
          close();
        },
        onRightClick: (close) {
          final texts = UnmodifiableListView(_texts);
          for (final text in texts) {
            onSelectText(text.id, false);
            onChangeTextPosition(0, 0, false);
          }
          onDeselectText(false);
          tale = tale.copyWith(orientation: orientation);
          close();
          notifyListeners();
        },
      );
    } else {
      tale = tale.copyWith(orientation: orientation);
      notifyListeners();
    }
  }

  //Tale

  //Translations
  late TaleLocalizationModel localization;

  void onChangeLocalizationDefaultLocale(String locale) {
    localization = localization.copyWith(defaultLocale: locale);
    notifyListeners();
  }

  void onUpdateLocalization(TaleLocalizationModel localization) {
    this.localization = localization;
    notifyListeners();
  }

  void gotoTranslationsEditor(BuildContext context) {
    void go() {
      if (context.mounted) {
        context
            .push<TaleLocalizationModel>(TranslationsView.route(tale.id))
            .then((value) {
              if (value != null) onUpdateLocalization(value);
            });
      }
    }

    if (isCreate) {
      PromptDialog.show(
        'Do you want to continue?',
        title: 'Tale will be created first!',
        onRightClick: (close) {
          onSave().then((value) {
            if (value) go();
          });
        },
      );
    } else {
      go();
    }
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

  void onSelectPage(String id, {bool notify = true}) {
    if (id != selectedPageId) {
      selectedPageId = id;
      selectedTextId = '';
      if (notify) notifyListeners();
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
      PromptDialog.show(
        "This action cannot be undone!",
        title: "Delete page?",
        isDestructive: true,
        onLeftClick: (close) {
          close();
        },
        onRightClick: (close) {
          //todo: delete from server
          _pages.removeWhere((element) => element.id == id);
          selectedPageId = '';
          notifyListeners();
          close();
        },
      );
    }
  }

  void _updatePage(TalePageModel page) {
    final index = _pages.indexWhere((element) => element.id == selectedPageId);
    if (index == -1) return;
    _pages[index] = page;
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

  void onChangePageBackgroundImage() async {
    if (selectedPage == null) return;
    //select image
    final result = await _filePickerRepository.pickImageFile();
    switch (result) {
      case ResultOk<PlatformFile?>():
        if (result.value != null) {
          //upload image
          final uploadResult = await _pageRepository.uploadBackgroundImage(
            pageId: selectedPageId,
            file: result.value!,
          );
          switch (uploadResult) {
            case ResultOk<String>():
              //set page background image
              _updatePage(
                selectedPage!.copyWith(
                  backgroundImageUrl:
                      "${uploadResult.value}?q=${DateTime.now().millisecondsSinceEpoch}",
                ),
              );
              notifyListeners();
              log.info("Page background image is set $selectedPageId");
              break;
            case ResultError<String>():
              ErrorDialog.show(uploadResult.toString());
              break;
          }
        }
        break;
      case ResultError<PlatformFile?>():
        ErrorDialog.show(result.toString());
        break;
    }
  }

  void onDeletePageBackgroundImage() {
    if (selectedPage == null) return;
    PromptDialog.show(
      "This action cannot be undone!",
      title: "Delete page background image?",
      isDestructive: true,
      onLeftClick: (close) {
        close();
      },
      onRightClick: (close) async {
        final result = await _pageRepository.deleteBackgroundImage(
          selectedPage!.backgroundImageBucketPath,
        );
        switch (result) {
          case ResultOk<void>():
            //todo: save page
            _updatePage(selectedPage!.copyWith(backgroundImageUrl: ""));
            notifyListeners();
            break;
          case ResultError<void>():
            ErrorDialog.show(result.toString());
            break;
        }
        close();
      },
    );
  }
  //Pages

  //Texts
  final List<TalePageTextModel> _texts = List.empty(growable: true);
  UnmodifiableListView<TalePageTextModel> get texts =>
      UnmodifiableListView(_texts);
  String selectedTextId = '';
  TalePageTextModel? get selectedText =>
      texts.firstWhereOrNull((element) => element.id == selectedTextId);

  void onSelectText(String id, [bool notify = true]) {
    if (id != selectedTextId) {
      selectedTextId = id;
      if (selectedText?.pageId != selectedPageId) {
        onSelectPage(selectedText!.pageId, notify: false);
        selectedTextId = id;
      }
      if (notify) notifyListeners();
    }
  }

  void onDeselectText([bool notify = true]) {
    if (selectedTextId.isNotEmpty) {
      selectedTextId = '';
      if (notify) notifyListeners();
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

  void onChangeTextPosition([double? dx, double? dy, bool notify = true]) {
    if (selectedTextId.isEmpty) return;
    if (dx == null && dy == null) return;

    _updateText(
      selectedText!.copyWith(
        dx: dx?.ceil().toDouble() ?? selectedText!.dx,
        dy: dy?.ceil().toDouble() ?? selectedText!.dy,
      ),
    );
    if (notify) notifyListeners();
  }

  void onChangeTextFontSize(double size) {
    if (selectedTextId.isEmpty) return;
    TextStyle style = selectedText!.style;
    style = style.copyWith(fontSize: size.ceil().toDouble());

    _updateText(selectedText!.copyWith(style: style));
    notifyListeners();
  }

  void onChangeTextFontColor(Color color) {
    if (selectedTextId.isEmpty) return;
    TextStyle style = selectedText!.style;
    style = style.copyWith(color: color);

    _updateText(selectedText!.copyWith(style: style));
    notifyListeners();
  }

  void onChangeTextBackgroundColor(Color? color) {
    if (selectedTextId.isEmpty) return;
    var decoration = selectedText!.decoration;
    decoration = decoration.copyWith(backgroundColor: color);

    _updateText(selectedText!.copyWith(decoration: decoration));
    notifyListeners();
  }

  void onChangeTextBorderRadius(double radius) {
    if (selectedTextId.isEmpty) return;
    var decoration = selectedText!.decoration;
    decoration = decoration.copyWith(
      borderRadius: BorderRadius.circular(radius),
    );

    _updateText(selectedText!.copyWith(decoration: decoration));
    notifyListeners();
  }

  void onChangeTextPadding(double padding) {
    if (selectedTextId.isEmpty) return;
    var decoration = selectedText!.decoration;
    decoration = decoration.copyWith(padding: EdgeInsets.all(padding));

    _updateText(selectedText!.copyWith(decoration: decoration));
    notifyListeners();
  }

  void onChangeTextAlignment(TextAlign alignment) {
    if (selectedTextId.isEmpty) return;
    var decoration = selectedText!.decoration;
    decoration = decoration.copyWith(textAlign: alignment);

    _updateText(selectedText!.copyWith(decoration: decoration));
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
      PromptDialog.show(
        "This action cannot be undone!",
        title: "Delete text?",
        isDestructive: true,
        onLeftClick: (close) {
          close();
        },
        onRightClick: (close) {
          //todo: delete from server
          _texts.removeWhere((element) => element.id == id);
          selectedTextId = '';
          notifyListeners();
          close();
        },
      );
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
