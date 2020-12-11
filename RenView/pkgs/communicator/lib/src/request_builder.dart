import 'package:functional_data/functional_data.dart';
import 'package:meta/meta.dart';
import 'package:plain_optional/plain_optional.dart';
import 'package:http/http.dart' as http;

part 'request_builder.g.dart';

// ignore_for_file: annotate_overrides

class ServerURL {
  static const local = 'http://localhost:9090';
  static const heroku = 'https://renview.herokuapp.com';
}

@FunctionalData()
class Request extends $Request {
  const Request({
    @required this.url,
    @required this.headers,
    this.body,
  });

  http.Request asHttpRequest(String method) {
    final request = http.Request(method, url);

    if (headers != null) request.headers.addAll(headers);
    if (body != null) {
      if (body is String) {
        request.body = body as String;
      } else if (body is List) {
        request.bodyBytes = (body as List).cast<int>();
      } else if (body is Map) {
        request.bodyFields = (body as Map).cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    return request;
  }

  final Uri url;
  final Map<String, String> headers;
  final dynamic body;
}

class RequestBuilder {
  static const serverURL = ServerURL.heroku;

  RequestBuilder({this.getSessionToken});

  Request build({
    @required bool authorized,
    @required String endpoint,
    Map<String, String> customHeaders = const {},
    Map<String, String> customQueryParameters = const {},
    Map<String, dynamic> body,
  }) {
    final queryParameters = {
      if (authorized) 'access_token': _sessionToken,
      ...customQueryParameters,
    };

    var url = [
      serverURL,
      endpoint,
    ].join('/');

    if (queryParameters.isNotEmpty) {
      url += '?${queryParameters.entries.map((e) => '${e.key}=${e.value}').join('&')}';
    }

    return Request(
      url: Uri.parse(url),
      headers: {
        ...customHeaders,
      },
      body: body,
    );
  }

  String get _sessionToken {
    final token = getSessionToken();
    assert(token.hasValue, 'Session token is not available while building authorized request');

    return token.unsafe;
  }

  final Optional<String> Function() getSessionToken;
}
