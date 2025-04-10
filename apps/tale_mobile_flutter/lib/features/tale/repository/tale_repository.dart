import 'package:myspace_core/myspace_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tale_mobile_flutter/features/tale/model/localization.dart';
import 'package:tale_mobile_flutter/features/tale/model/page.dart';
import 'package:tale_mobile_flutter/features/tale/model/tale.dart';
import 'package:tale_mobile_flutter/features/tale/model/text.dart';

class TaleRepository extends Dependency {
  final SupabaseClient _client;

  const TaleRepository(SupabaseClient client) : _client = client;

  Future<Result<List<TaleModel>>> getMyTales() async {
    try {
      final response =
          await _client.from("tales").select(); //todo: fetch only my tales
      await Future.delayed(Duration(seconds: 1));
      return Result.ok(response.map((e) => TaleModel.fromJson(e)).toList());
    } catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<FullTaleResponse>> getTale(String id) async {
    try {
      final response =
          await _client
              .from("tales")
              .select("*, localization:localizations(*), pages(*, texts(*))")
              .eq("id", id)
              .single();
      // await Future.delayed(Duration(seconds: 1));
      final tale = TaleModel.fromJson(response);
      final localization = TaleLocalizationModel.fromJson(
        response['localization'],
      );
      final texts = <TalePageTextModel>[];
      final pages =
          (response['pages'] as List).map((page) {
            texts.addAll(
              (page['texts'] as List).map(
                (text) => TalePageTextModel.fromJson(text),
              ),
            );
            return TalePageModel.fromJson(page);
          }).toList();
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
