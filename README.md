![GitHub License](https://img.shields.io/github/license/ricardoboss/dart_seq_hive_cache)
![Pub Version](https://img.shields.io/pub/v/dart_seq_hive_cache)
![Pub Points](https://img.shields.io/pub/points/dart_seq_hive_cache)
![Pub Likes](https://img.shields.io/pub/likes/dart_seq_hive_cache)
![Pub Popularity](https://img.shields.io/pub/popularity/dart_seq_hive_cache)

An extension for [`dart_seq`](https://pub.dev/packages/dart_seq) that provides a local database for log events using Hive.

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

![Screenshot from Seq showing the result of the above code](https://raw.githubusercontent.com/ricardoboss/dart_seq_hive_cache/44af7da53b1a871a5150f521b83b7e3512b3deec/docs/Screenshot%202024-03-20%20050912.png)

## Additional information

Please open issues on GitHub if you want to request a feature or report a bug.

Pull requests are welcome!
