import 'package:just_audio/just_audio.dart';
import 'package:myspace_data/myspace_data.dart';

abstract class AudioPlayerService {
  final AudioPlayer _player;

  const AudioPlayerService(this._player);

  ResultFuture<void> playFromUrl(String url) async {
    try {
      //returns the duration of the audio
      await _player.setUrl(url);
      final result = play();
      return result;
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  ResultFuture<void> pause() async {
    try {
      await _player.pause();
      return Result.ok(null);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  ResultFuture<void> stop() async {
    try {
      await _player.stop();
      return Result.ok(null);
    } catch (e, st) {
      return Result.error(ErrorX(e, st));
    }
  }

  ResultFuture<void> play() async {
    try {
      await _player.play();
      return Result.ok(null);
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

  Stream<bool> get isPlayingStream => _player.playingStream;
}

//main player service
class MainAudioPlayerServiceImpl extends AudioPlayerService {
  const MainAudioPlayerServiceImpl(super.player);
}
