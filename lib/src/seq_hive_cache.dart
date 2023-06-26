import 'package:dart_seq/dart_seq.dart';
import 'package:dart_seq_hive_cache/src/seq_event_type_adapter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class SeqHiveCache implements SeqCache {
  static Future<SeqHiveCache> create([
    String hiveName = 'seq_hive_cache',
    String boxName = 'seq_cache',
  ]) async {
    final tempDir = await getTemporaryDirectory();
    Hive.init('${tempDir.path}/$hiveName');

    Hive.registerAdapter(SeqEventTypeAdapter());

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
  Stream<SeqEvent> take(int count) async* {
    for (var i = 0; i < count && _box.isNotEmpty; i++) {
      final event = _box.getAt(0);
      if (event == null) break;

      yield event;

      await _box.deleteAt(0);
    }
  }
}
