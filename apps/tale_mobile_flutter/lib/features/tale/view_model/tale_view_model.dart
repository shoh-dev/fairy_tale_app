import 'package:collection/collection.dart';
import 'package:just_audio/just_audio.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:tale_mobile_flutter/features/tale/model/page.dart';
import 'package:tale_mobile_flutter/features/tale/model/tale.dart';
import 'package:tale_mobile_flutter/repository/tale_repository.dart';

class TaleViewModel extends Vm {
  final TaleRepository _taleRepository;

  @override
  void dispose() async {
    if (_backgroundAudioPlayer != null) {
      await _backgroundAudioPlayer!.stop();
      await _backgroundAudioPlayer!.dispose();
    }
    super.dispose();
  }

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
        if (_tale.backgroundAudioUrl.isNotEmpty) {
          _initAudioPlayer(_tale.backgroundAudioUrl);
        }
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

  AudioPlayer? _backgroundAudioPlayer;

  void _initAudioPlayer(String url) async {
    _backgroundAudioPlayer =
        AudioPlayer()
          ..setLoopMode(LoopMode.all)
          ..setAudioSource(AudioSource.uri(Uri.parse(url)))
          ..play();
  }

  void playAudio() {
    try {
      _backgroundAudioPlayer?.play();
    } catch (e) {
      log.warning("Error playing background audio", e);
    }
  }

  void stopAudio() {
    try {
      _backgroundAudioPlayer?.stop();
    } catch (e) {
      log.warning("Error stopping background audio", e);
    }
  }

  void pauseAudio() {
    try {
      _backgroundAudioPlayer?.pause();
    } catch (e) {
      log.warning("Error pausing background audio", e);
    }
  }

  Stream<bool>? isAudioPlayingStream() {
    return _backgroundAudioPlayer?.playingStream;
  }

  void toggleAudio() {
    if (_backgroundAudioPlayer == null) return;
    if (_backgroundAudioPlayer!.playing) {
      pauseAudio();
      return;
    }
    playAudio();
  }

  bool get hasBackgroundAudio => _backgroundAudioPlayer != null;
}
