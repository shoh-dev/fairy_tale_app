extension IterableHelper<T> on Iterable<T> {
  //firstWhereOrNull
  T? firstWhereOrNull(bool Function(T e) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}
