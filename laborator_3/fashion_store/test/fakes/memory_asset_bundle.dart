import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class MemoryAssetBundle extends AssetBundle {
  MemoryAssetBundle(this.content);

  MemoryAssetBundle.fromFile(String path)
    : content = File(path).readAsStringSync();

  final String content;

  @override
  Future<ByteData> load(String key) async =>
      ByteData.sublistView(utf8.encode(content));

  @override
  Future<String> loadString(String key, {bool cache = true}) async => content;

  @override
  Future<T> loadStructuredData<T>(
    String key,
    Future<T> Function(String value) parser,
  ) => parser(content);

  @override
  void evict(String key) {}
}
