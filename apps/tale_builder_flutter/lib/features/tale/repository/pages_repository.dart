import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_builder_flutter/features/tale/model/page.dart';

class TalePagesRepository extends Dependency {
  final SupabaseClient _client;

  const TalePagesRepository(SupabaseClient client) : _client = client;

  // Future<Result<List<TalePageModel>>> getPages(String taleId) async {
  //   try {
  //     final response = await _client
  //         .from("pages")
  //         .select()
  //         .eq("tale_id", taleId);
  //     return Result.ok(response.map((e) => TalePageModel.fromJson(e)).toList());
  //   } catch (e) {
  //     return Result.error(e);
  //   }
  // }

  //Returns publish url path
  Future<Result<String>> uploadBackgroundImage({
    required String pageId,
    required PlatformFile file,
  }) async {
    try {
      final bytes = await file.xFile.readAsBytes();
      final ext = file.extension!.toLowerCase();
      final path = 'page/background/$pageId.$ext';
      await _client.storage
          .from('default')
          .uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );
      final publicUrl = _client.storage.from('default').getPublicUrl(path);
      return Result.ok(publicUrl);
    } catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteBackgroundImage(String path) async {
    try {
      await _client.storage.from('default').remove([path]);
      return Result.ok(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  // Future<Result<void>> updatePage(TalePageModel page) async {
  //   try {
  //     log(path);
  //     final res = await _client.storage.from('default').remove([path]);
  //     log(res.toString());
  //     return Result.ok(null);
  //   } catch (e) {
  //     return Result.error(e);
  //   }
  // }
}
