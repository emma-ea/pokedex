class PokedexList {
  final int count;
  final String next;
  final dynamic prev;
  final List<Result> results;

  PokedexList(
      {required this.count,
      required this.next,
      this.prev,
      required this.results});

  factory PokedexList.fromMap(dynamic map) {
    return PokedexList(
      count: map['count'],
      next: map['next'],
      prev: map['previous'],
      results: List<Result>.from(map['results'].map((x) => Result.fromMap(x))),
    );
  }

  @override
  String toString() {
    return "$count $next $prev $results";
  }
}

class Result {
  final String name;
  final String url;

  Result({required this.name, required this.url});

  factory Result.fromMap(dynamic map) {
    return Result(
      name: map['name'],
      url: map['url']
    );
  }

  @override
  String toString() {
    return "[$name $url]";
  }
}
