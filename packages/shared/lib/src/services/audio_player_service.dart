import 'package:just_audio/just_audio.dart';
import 'package:myspace_data/myspace_data.dart';

abstract class AudioPlayerService {
  final AudioPlayer _player;

  const AudioPlayerService(this._player);

  void dispose() {
    _player.dispose();
  }

  ResultFuture<void> playFromUrl(String url) async {
    try {
      //returns the duration of the audio
      await _player.setUrl(url);
      final result = play();
      return result;
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  ResultFuture<void> pause() async {
    try {
      await _player.pause();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  ResultFuture<void> stop() async {
    try {
      await _player.stop();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  ResultFuture<void> play() async {
    try {
      await _player.play();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
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
class MainAudioPlayerService extends AudioPlayerService {
  MainAudioPlayerService() : super(AudioPlayer());
}

class InteractionAudioPlayerService extends AudioPlayerService {
  InteractionAudioPlayerService() : super(AudioPlayer());
}
