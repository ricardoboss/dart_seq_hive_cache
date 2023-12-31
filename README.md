An extension for `dart_seq` that provides a local database for log events using Hive.

## Features

- Provides an implementation of `SeqCache` from `dart_seq`
- Stores events on disk until `flush` is called on the logger
- Preserves events between sessions (useful for troubleshooting)

## Getting started

Install both `dart_seq` and `dart_seq_hive_cache`:

```shell
dart pub add dart_seq dart_seq_hive_cache
```

## Usage

```dart
final cache = await SeqHiveCache.create();

final logger = SeqLogger.http(
  host: "http://localhost:5341",
  cache: cache,
);

await logger.log(SeqLogLevel.information, "before loop");

for (var i = 0; i < 10; i++) {
  await logger.log(SeqLogLevel.information, i.toString());

  print('events in cache: ${cache.count}');

  await Future.delayed(const Duration(seconds: 1));
}

await logger.log(SeqLogLevel.information, "after loop");

await logger.flush();
```

## Additional information

Please open issues on GitHub if you want to request a feature or report a bug.

Pull requests are welcome!
