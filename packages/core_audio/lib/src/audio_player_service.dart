import 'package:just_audio/just_audio.dart';
import 'package:myspace_data/myspace_data.dart';

abstract class AudioPlayerService {
  ResultFuture<bool> playFromUrl(String url);
}

class AudioPlayerServiceImpl implements AudioPlayerService {
  final AudioPlayer player;

  const AudioPlayerServiceImpl(this.player);

  @override
  ResultFuture<bool> playFromUrl(String url) async {
    try {
      final result = await player.setUrl(url);
      print(result);
      await player.play();
      return Result.ok(true);
    } on PlayerException catch (e, st) {
      print(e.code);
      print(e.details);
      print(e.message);
      return Result.error(ErrorX(e, st));
    } catch (e, st) {
      print(e);
      return Result.error(ErrorX(e, st));
    }
  }
}
