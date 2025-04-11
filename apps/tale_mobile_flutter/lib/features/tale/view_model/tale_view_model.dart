import 'package:collection/collection.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_mobile_flutter/features/tale/model/page.dart';
import 'package:tale_mobile_flutter/features/tale/model/tale.dart';
import 'package:tale_mobile_flutter/repository/tale_repository.dart';

class TaleViewModel extends Vm {
  final TaleRepository _taleRepository;

  TaleViewModel(String id, {required TaleRepository taleRepository})
    : _taleRepository = taleRepository {
    fetchTaleCommand = CommandParam(_fetchMyTales)..execute(id);
  }

  //Tale
  late final CommandParam<void, String> fetchTaleCommand;
  late final TaleModel _tale;
  String get taleId => _tale.id;

  Future<Result<void>> _fetchMyTales(String id) async {
    final result = await _taleRepository.getTale(id);
    switch (result) {
      case ResultOk<TaleModel>(:final value):
        _tale = value;
        _currentLocale = _tale.localization.defaultLocale;
        log.info("Fetched tale");
        notifyListeners();
        return Result.ok(null);
      case ResultError<TaleModel>():
        log.warning('Fetch tale error: ${result.e}');
        notifyListeners();
        return Result.error(result.e);
    }
  }

  late String _currentLocale;

  UnmodifiableMapView<String, String> get translations =>
      UnmodifiableMapView(_tale.localization.translations[_currentLocale]!);

  UnmodifiableListView<TalePageModel> get pages =>
      UnmodifiableListView(_tale.pages);
}
