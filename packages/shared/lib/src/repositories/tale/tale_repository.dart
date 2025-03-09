import 'dart:developer';
import 'dart:typed_data';

import 'package:myspace_data/myspace_data.dart';
import 'package:shared/src/repositories/tale/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TaleRepository {
  ResultFuture<List<Tale>> getAllTales();
  ResultFuture<Tale> getTaleById(String taleId);
  ResultFuture<void> saveTaleLocalization({
    required String taleId,
    required Map<String, Map<String, String>> translations,
    required String defaultLocale,
  });
  ResultFuture<void> saveTale(Tale tale);
  ResultFuture<void> saveTalePages(List<TalePage> pages);
  ResultFuture<void> saveTaleInteractions(List<TaleInteraction> ineractions);
  ResultFuture<String> uploadFile({
    required Uint8List bytes,
    required String path,
  });
  ResultFuture<void> deleteTalePage(String id);
  ResultFuture<void> deleteTale(String id);
}

class TaleRepositoryImpl implements TaleRepository {
  final SupabaseClient _supabase;

  const TaleRepositoryImpl(this._supabase);

  @override
  ResultFuture<List<Tale>> getAllTales() async {
    try {
      final response = await _supabase
          .from('tales')
          .select('id, title, description, metadata')
          .order('created_at');

      return Result.ok(response.map(Tale.fromJson).toList());
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<Tale> getTaleById(String taleId) async {
    try {
      final response = await _supabase
          .from('tales')
          .select('*, pages(*, interactions(*)), localizations(*)')
          .eq('id', taleId)
          .single();

      return Result.ok(Tale.fromJson(response));
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> saveTaleLocalization({
    required String taleId,
    required Map<String, Map<String, String>> translations,
    required String defaultLocale,
  }) async {
    try {
      await _supabase.from('localizations').upsert({
        'tale_id': taleId,
        'translations': translations,
        'default_locale': defaultLocale,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> saveTale(Tale tale) async {
    try {
      await _supabase.from('tales').upsert(tale.toJson());
      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> saveTalePages(List<TalePage> pages) async {
    try {
      await _supabase
          .from('pages')
          .upsert(pages.map((e) => e.toJson()).toList());

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> saveTaleInteractions(
    List<TaleInteraction> ineractions,
  ) async {
    try {
      log(ineractions.map((e) => e.toJson()).toList().toString());
      await _supabase.from('interactions').upsert(
            ineractions.map((e) => e.toJson()).toList(),
          );

      return const Result.ok(null);
    } catch (e) {
      log(e.toString());
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<String> uploadFile({
    required Uint8List bytes,
    required String path,
  }) async {
    try {
      await _supabase.storage.from('default').uploadBinary(
            path,
            bytes,
            fileOptions: const FileOptions(upsert: true),
          );

      final publicUrl = _supabase.storage.from('default').getPublicUrl(path);

      return Result.ok(publicUrl);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> deleteTalePage(String id) async {
    try {
      await _supabase.from('pages').delete().eq('id', id);

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }

  @override
  ResultFuture<void> deleteTale(String id) async {
    try {
      await _supabase.from('tales').delete().eq('id', id);

      return const Result.ok(null);
    } catch (e) {
      return Result.error(ErrorX(e));
    }
  }
}
