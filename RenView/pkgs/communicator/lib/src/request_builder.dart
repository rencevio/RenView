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

  RequestBuilder({@required this.getSessionToken});

  Request build({
    @required String endpoint,
  }) =>
      Request(
        url: Uri.parse(
          [
            serverURL,
            endpoint,
          ].join('/'),
        ),
        headers: {},
      );

  final Optional<String> Function() getSessionToken;
}
