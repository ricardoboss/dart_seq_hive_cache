import 'dart:async';

import 'package:dart_seq/dart_seq.dart';
import 'package:dart_seq_hive_cache/dart_seq_hive_cache.dart';

void main() async {
  final cache = await SeqHiveCache.create();

  final logger = SeqLogger.http(
    host: "http://localhost:5341",
    cache: cache,
    backlogLimit: 3,
  );

  print('events in cache: ${cache.count}');

  await logger.log(SeqLogLevel.information, "before loop");

  for (var i = 0; i < 10; i++) {
    await logger.log(SeqLogLevel.information, i.toString());

    print('events in cache: ${cache.count}');

    await Future.delayed(const Duration(seconds: 1));
  }

  await logger.log(SeqLogLevel.information, "after loop");

  await logger.flush();

  await logger.log(SeqLogLevel.information, "after flush");

  print('events in cache: ${cache.count}');
}
