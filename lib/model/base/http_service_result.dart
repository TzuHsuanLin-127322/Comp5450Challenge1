class HttpServiceResult<T> {
  final int statusCode;
  final T? data;
  final String? message;

  HttpServiceResult({required this.statusCode, this.data, this.message});
}

