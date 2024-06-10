## Unreleased

* Updated `dart_seq` to 2.0.0

## 1.0.0-pre.1

* Changed SDK constraint to `^3.0.0`
* Updated `dart_seq` to 1.0.0
* Added GitHub Actions workflows

## 0.0.6

* Fix invalid implementation of `peek` where only the first entry is returned multiple times

## 0.0.5

* Updated to `dart_seq` 0.1.0
* Removed `registerSeqEventTypeAdapter` from `SeqHiveCache.create` factory
    * If you still want to override the default `SeqEventTypeAdapter` you can do so by
      calling `Hive.registerAdapter(MySeqEventTypeAdapter(), override: true)` after
      calling `SeqHiveCache.create`

## 0.0.4

* Fix use of invalid type id

## 0.0.3

* Make unique id publicly and statically accessible
* Added ability to disable registering the default SeqEvent type adapter
* Simplify reading back exceptions
* Updated to `dart_seq` 0.0.4

## 0.0.2

* Removed dependency on `path_provider` in favour of `dart:io` (removes compatibility with web
  platforms)

## 0.0.1

* Initial release 🎉
* Supports creating an `SeqHiveCache` for use in an `SeqLogger`
