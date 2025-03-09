import 'package:file_picker/file_picker.dart';
import 'package:myspace_data/myspace_data.dart';

class FilePickerService {
  const FilePickerService();

  ResultFuture<PlatformFile?> pickPNGFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png'],
      );

      return Result.ok(result?.files.firstOrNull);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  ResultFuture<PlatformFile?> pickAudioFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        // allowedExtensions: ['mp3'],
      );

      return Result.ok(result?.files.firstOrNull);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }
}
