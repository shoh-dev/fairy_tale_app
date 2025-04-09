import 'package:file_picker/file_picker.dart';
import 'package:myspace_core/myspace_core.dart';

class FilePickerRepository extends Dependency {
  const FilePickerRepository();

  Future<Result<PlatformFile?>> pickImageFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpeg'],
      );

      return Result.ok(result?.files.firstOrNull);
    } catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<PlatformFile?>> pickAudioFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.audio);

      return Result.ok(result?.files.firstOrNull);
    } catch (e) {
      return Result.error(e);
    }
  }
}
