class Triple<T, U, K> {
  Triple(this.first, this.second, this.third);

  final T first;
  final U second;
  final K third;

  @override
  String toString() => 'Triple[$first, $second, $third]';
}