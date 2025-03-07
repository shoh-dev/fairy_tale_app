import 'package:file_picker/file_picker.dart';
import 'package:myspace_data/myspace_data.dart';

class FilePickerService {
  const FilePickerService();

  ResultFuture<FilePickerResult?> pickFile(FileType type) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: type,
      );

      return Result.ok(result);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }
}
