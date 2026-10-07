typedef JsonMap = Map<String, dynamic>;

List<T> parseList<T>(Object? raw, T Function(JsonMap) parse) {
  return (raw as List<dynamic>? ?? const [])
      .map((item) => parse(item as JsonMap))
      .toList(growable: false);
}
