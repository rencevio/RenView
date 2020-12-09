// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_builder.dart';

// **************************************************************************
// FunctionalDataGenerator
// **************************************************************************

// ignore_for_file: join_return_with_assignment
// ignore_for_file: avoid_classes_with_only_static_members
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes
abstract class $Request {
  const $Request();
  Uri get url;
  Map<String, String> get headers;
  dynamic get body;
  Request copyWith({Uri url, Map<String, String> headers, dynamic body}) =>
      Request(
          url: url ?? this.url,
          headers: headers ?? this.headers,
          body: body ?? this.body);
  @override
  String toString() => "Request(url: $url, headers: $headers, body: $body)";
  @override
  bool operator ==(dynamic other) =>
      other.runtimeType == runtimeType &&
      url == other.url &&
      headers == other.headers &&
      body == other.body;
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + url.hashCode;
    result = 37 * result + headers.hashCode;
    result = 37 * result + body.hashCode;
    return result;
  }
}

class Request$ {
  static final url =
      Lens<Request, Uri>((s_) => s_.url, (s_, url) => s_.copyWith(url: url));
  static final headers = Lens<Request, Map<String, String>>(
      (s_) => s_.headers, (s_, headers) => s_.copyWith(headers: headers));
  static final body = Lens<Request, dynamic>(
      (s_) => s_.body, (s_, body) => s_.copyWith(body: body));
}
