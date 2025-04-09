import 'package:myspace_core/myspace_core.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_builder_flutter/features/tale/model/localization.dart';
import 'package:tale_builder_flutter/features/tale/model/page.dart';
import 'package:tale_builder_flutter/features/tale/model/tale.dart';
import 'package:tale_builder_flutter/features/tale/model/text.dart';

class TaleRepository extends Dependency {
  final SupabaseClient _client;

  const TaleRepository(SupabaseClient client) : _client = client;

  Future<Result<TaleModel>> getTale(String id) async {
    try {
      final response =
          await _client.from("tales").select().eq("id", id).single();
      return Result.ok(TaleModel.fromJson(response));
    } catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<FullTaleResponse>> getTaleFull(String id) async {
    try {
      final response =
          await _client
              .from("tales")
              .select("*, localization:localizations(*), pages(*), texts(*)")
              .eq("id", id)
              .single();
      await Future.delayed(Duration(seconds: 1));
      final tale = TaleModel.fromJson(response);
      final localization = TaleLocalizationModel.fromJson(
        response['localization'],
      );
      final pages =
          (response['pages'] as List)
              .map((e) => TalePageModel.fromJson(e))
              .toList();
      final texts =
          (response['texts'] as List)
              .map((e) => TalePageTextModel.fromJson(e))
              .toList();
      return Result.ok(FullTaleResponse(tale, localization, pages, texts));
    } catch (e) {
      return Result.error(e);
    }
  }
}

final class FullTaleResponse {
  final TaleModel tale;
  final TaleLocalizationModel localization;
  final List<TalePageModel> pages;
  final List<TalePageTextModel> texts;

  const FullTaleResponse(this.tale, this.localization, this.pages, this.texts);
}
