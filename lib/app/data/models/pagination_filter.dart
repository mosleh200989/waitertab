class PaginationFilter {
  int offset;
  int limit;

  @override
  String toString() => 'PaginationFilter(offset: $offset, limit: $limit)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaginationFilter && o.offset == offset && o.limit == limit;
  }

  @override
  int get hashCode => offset.hashCode ^ limit.hashCode;
}