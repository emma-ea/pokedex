class PokedexException implements Exception {
  final String _error;
  final String _prefix;

  PokedexException(this._prefix, this._error);

  get error => _error;

  @override
  String toString() {
    return "[$_prefix]: $_error";
  }
}

class TimeoutException extends PokedexException {
  TimeoutException(String error) : super("TimeoutException", error);
}

class RequestException extends PokedexException {
  RequestException(String error) : super("RequestException", error);
}

class FetchException extends PokedexException {
  FetchException(String error) : super("FetchException", error);
}
