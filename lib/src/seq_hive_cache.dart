import 'dart:io';

import 'package:dart_seq/dart_seq.dart';
import 'package:dart_seq_hive_cache/src/seq_event_type_adapter.dart';
import 'package:hive/hive.dart';

class SeqHiveCache implements SeqCache {
  static Future<SeqHiveCache> create({
    String hiveName = 'seq_hive_cache',
    String boxName = 'seq_cache',
  }) async {
    Hive.registerAdapter(SeqEventTypeAdapter(), override: false);

    // TODO: implement a platform-agnostic way to initialize Hive
    final tempDir = Directory.systemTemp;
    Hive.init('${tempDir.path}/$hiveName');

    final box = await Hive.openBox<SeqEvent>(boxName);

    return SeqHiveCache._(box);
  }

  final Box<SeqEvent> _box;

  SeqHiveCache._(this._box);

  @override
  int get count => _box.length;

  @override
  Future<void> record(SeqEvent event) async => await _box.add(event);

  @override
  Stream<SeqEvent> peek(int count) async* {
    final max = count.clamp(0, _box.length);
    for (var i = 0; i < max; i++) {
      final event = _box.getAt(0);
      if (event == null) break;

      yield event;
    }
  }

  @override
  Future<void> remove(int count) async {
    final max = count.clamp(0, _box.length);

    for (var i = 0; i < max; i++) {
      await _box.deleteAt(0);
    }
  }
}
