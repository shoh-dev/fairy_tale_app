import 'package:just_audio/just_audio.dart';
import 'package:myspace_data/myspace_data.dart';

abstract class MainAudioPlayerService {
  ResultFuture<bool> playFromUrl(String url);
}

//main player service
class MainAudioPlayerServiceImpl implements MainAudioPlayerService {
  final AudioPlayer _player;

  const MainAudioPlayerServiceImpl(this._player);

  @override
  ResultFuture<bool> playFromUrl(String url) async {
    try {
      //returns the duration of the audio
      await _player.setUrl(url);
      final result = play();
      return result;
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  bool isPlaying() {
    try {
      return _player.playing;
    } catch (e) {
      return false;
    }
  }

  ResultFuture<bool> pause() async {
    try {
      await _player.pause();
      return Result.ok(true);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  ResultFuture<bool> stop() async {
    try {
      await _player.stop();
      return Result.ok(true);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  ResultFuture<bool> play() async {
    try {
      await _player.play();
      return Result.ok(true);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  Stream<bool> get isPlayingStream => _player.playingStream;
}
