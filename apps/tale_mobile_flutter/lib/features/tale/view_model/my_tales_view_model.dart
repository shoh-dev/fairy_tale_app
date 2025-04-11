import 'package:collection/collection.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_mobile_flutter/features/tale/model/tale.dart';
import 'package:tale_mobile_flutter/features/tale/repository/tale_repository.dart';

class MyTalesViewModel extends Vm {
  final TaleRepository _taleRepository;

  MyTalesViewModel({required TaleRepository taleRepository})
    : _taleRepository = taleRepository {
    fetchMyTalesCommand = CommandNoParam(_fetchMyTales)..execute();
  }

  //Tale
  late final CommandNoParam<void> fetchMyTalesCommand;
  final List<TaleModel> _myTales = List.empty(growable: true);
  UnmodifiableListView<TaleModel> get tales => UnmodifiableListView(_myTales);

  Future<Result<void>> _fetchMyTales() async {
    final result = await _taleRepository.getMyTales();
    switch (result) {
      case ResultOk<List<TaleModel>>(:final value):
        _myTales
          ..clear()
          ..addAll(value);
        log.info("Fetched my tales");
        notifyListeners();
        return Result.ok(null);
      case ResultError<List<TaleModel>>():
        log.warning('Fetch my tales error: ${result.e}');
        notifyListeners();
        return Result.error(result.e);
    }
  }
}
