import 'dart:developer';

import 'package:just_audio/just_audio.dart';
import 'package:myspace_data/myspace_data.dart';

export 'package:just_audio/just_audio.dart' show ProcessingState;

final audioPlayerPool = <AudioPlayerService>[];

abstract class AudioPlayerService {
  final AudioPlayer _player;

  AudioPlayerService(this._player) {
    log('Initializing $this');
    audioPlayerPool.add(this);
  }

  void dispose() {
    log('Disposing $this');
    _player.dispose();
  }

  ResultFuture<void> playFromUrl(String url) async {
    try {
      // await stop();//not sure why
      //returns the duration of the audio
      await _player.setUrl(url);
      return play();
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  ResultFuture<void> pause({bool ifPlaying = true}) async {
    try {
      if (ifPlaying && !isPlaying()) {
        return const Result.ok(null);
      }
      await _player.pause();
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  ResultFuture<void> stop({bool ifPlaying = true}) async {
    try {
      if (ifPlaying && !isPlaying()) {
        return const Result.ok(null);
      }
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
      return _player.playerState.processingState == ProcessingState.ready &&
          _player.playerState.playing;
    } catch (e) {
      return false;
    }
  }

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
}

//main player service
class MainAudioPlayerService extends AudioPlayerService {
  MainAudioPlayerService() : super(AudioPlayer());
}

class InteractionAudioPlayerService extends AudioPlayerService {
  InteractionAudioPlayerService() : super(AudioPlayer());
}

class BackgroundAudioService extends AudioPlayerService {
  BackgroundAudioService() : super(AudioPlayer());
}
